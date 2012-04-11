require 'nexpose/site'

module Nexty
  class Device
    def self.all(connection)
      @devices = []

      r = connection.execute('<SiteDeviceListingRequest session-id="' + connection.session_id + '"/>')
      if (r.success)
        r.res.elements.each('SiteDeviceListingResponse/SiteDevices') do |rr|
          @sid = rr.attribute("site-id")
          rr.elements.each('device') do |d|
            @devices.push(Nexpose::Device.new(d.attributes['id'], @sid, d.attributes["address"], d.attributes["riskfactor"], d.attributes['riskscore']))
          end
        end
			end
      @devices
    end

    def self.find_by_address(connection, address)
      devices = Nexty::Device.all(connection)
      devices.each do |d|
        if d.address == address
          return d
        end
      end

      return nil
    end
  end
end
