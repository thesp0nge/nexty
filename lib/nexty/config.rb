require 'singleton'
require 'yaml'

module Nexty
  class Config
    include Singleton

    def read(file)
      if file.nil? or !File.exists?(file)
        return {"config" => {"host"=>"127.0.0.1", "port"=>"3790", "user"=>"nxadmin", "pass"=>"nxadmin"}}
      end
      config = YAML.load_file(file)

      return config
    end


  end
end
