module Nexpose
  module NexposeAPI
    include XMLUtils

    def find_site_by_name(name)
      r = execute(make_xml('SiteListingRequest', {}))

			if (r.success)
				res = []
				r.res.elements.each("//SiteSummary") do |site|
          if (site.attributes['name'] == name) 
            res << {
              :site_id => site.attributes['id'].to_i,
              :name => site.attributes['name'].to_s,
              :risk_factor => site.attributes['riskfactor'].to_f,
              :risk_score => site.attributes['riskscore'].to_f,
            }
          end
				end
				res
			else
				false
			end

    end
  end
end

