module Nexty
  class Report
    
    def self.generate_and_save(site_list, nsc)
      site_list=Nexty::Sites.load_from_file(site_list)
      site_list_score = 0

      report = Nexpose::ReportAdHoc.new(nsc, 'basic-vulnerability-check-results', 'csv')

      site_list.each do |site|
        s = nsc.find_site_by_name_2(site) || []

        if ! s[:site_id].nil?
          site_config = Nexpose::SiteConfig.new
          site_config.getSiteConfig(nsc, s[:site_id])

          scan_history = nsc.site_scan_history(s[:site_id])
          scan_history.sort! { |a,b| b[:start_time] <=> a[:start_time]}
          scan_history.take(4).each do |scan|
            report.addFilter('scan', scan[:scan_id])
          end
        end
      end

      file_name = "export_#{Time.now.strftime("%Y%m%d%H%M%s")}.csv"
      file = File.open(file_name, "w")
      file.write(report.generate)
      file.close

      file_name

    end
  end
end
