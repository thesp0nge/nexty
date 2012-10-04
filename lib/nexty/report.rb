module Nexty
  class Report
    
    # def self.generate_from_ip_list(ip_list, nsc)
    #   ips = Nexty::Sites.load_from_file(ip_list)

    #   report = Nexpose::ReportAdHoc.new(nsc, 'SOX Vulns', 'csv')
    #   ips.each do |ip|
    #     report.addFilter('device',addFilter('device',  
    #   end
    # end


    def self.download(url, filename, nsc)
      return nil if url.nil? or url.empty?
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # XXX: security issue
      headers = {'Cookie' => "nexposeCCSessionID=#{nsc.session_id}"}
      resp = http.get(uri.path, headers)

      file = File.open(filename, "w")
      file.write(resp.body)
      file.close

      filename
    end

    def self.generate(nsc, list, options={:template=>'', :filename=> '', :format=>"csv", :scan_to_include=>1})

      options[:filename] = "export_#{Time.now.strftime("%Y%m%d%H%M%s")}.csv" if options[:filename].nil? or options[:filename].empty?
      report = Nexpose::ReportConfig.new(nsc)
      report.set_name(options[:filename])
      report.set_template_id(options[:template])
      report.set_format(options[:format])

      list.each do |item|
        site_config = Nexpose::SiteConfig.new
        site_config.getSiteConfig(nsc, item[:site_id])
        scan_history = nsc.site_scan_history(item[:site_id])
        scan_history.sort! { |a,b| b[:start_time] <=> a[:start_time]}
        scan_history.take(options[:scan_to_include]).each do |scan|
          report.addFilter('scan', scan[:scan_id])
        end
      end

      report.saveReport

      url = nil
      while not url
        url = nsc.report_last(report.config_id)
        select(nil, nil, nil, 10)
      end

      full_url="https://#{nsc.host}:#{nsc.port}#{url}"

      {:url=>full_url, :filename=>options[:filename]}
    end

    def self.generate_from_a_template(template_name, nsc)
      sites=nsc.site_listing
      result = Nexty::Report.generate(nsc, sites, {:template=>template_name, :filename=>nil, :format=>'csv', :scan_to_include=>1})
      result[:url]
    end

    def self.generate_from_a_list_of_sites(site_list=nil, nsc)
      sites=Nexty::Sites.load_from_file(site_list)
      s = []
      sites.each do |site|
        s << nsc.find_site_by_name(site) 
      end
      result = Nexty::Report.generate(nsc, s, {:template=>"template-per-vulnerability-meeting", :format=>'csv', :filename=>nil, :scan_to_include=>4})
      Nexty::Report.download(result[:url], result[:filename], nsc)
    end
  end
end
