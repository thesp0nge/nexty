require 'singleton'
require 'yaml'

module Nexty
  class Config
    include Singleton

    def initialize
      @default = {"config" => {"host"=>"127.0.0.1", "port"=>"3790", "user"=>"nxadmin", "pass"=>"nxadmin"}}
    end

    def read(file)
      if file.nil? or !File.exists?(file)
        return @default
      end
      config = YAML.load_file(file)

      return config
    end

  end
end
