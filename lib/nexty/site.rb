module Nexty
  class Sites
    # Public: load site names from a text file returning it in an array
    #
    # file - the filename
    #
    # Example
    #   Nexty::Sites.load_from_file('./important_sites.txt')
    #   # => ['www', 'mail', 'dns']
    #
    #   Nexty::Sites.load_from_file('./doesnt_exists_file.foo')
    #   # => []
    #
    # Returns an Array containing the site names or an empty Array if the file
    # doesn't exist.
    def self.load_from_file(file)
      if !File.exists?(file)
        return []
      end

      ret = [] 
      File.open(file).each_line{ |s|
        ret << s.chomp
      }
      
      ret 

    end
  end
end
# module Nexpose
#   module NexposeAPI
#     include XMLUtils
# 
#     def find_site_by_name(name)
#       r = execute(make_xml('SiteListingRequest', {}))
# 
# 			if (r.success)
# 				res = []
# 				r.res.elements.each("//SiteSummary") do |site|
#           if (site.attributes['name'] == name) 
#             res << {
#               :site_id => site.attributes['id'].to_i,
#               :name => site.attributes['name'].to_s,
#               :risk_factor => site.attributes['riskfactor'].to_f,
#               :risk_score => site.attributes['riskscore'].to_f,
#             }
#           end
# 				end
# 				res
# 			else
# 				false
# 			end
# 
#     end
#   end
# end

