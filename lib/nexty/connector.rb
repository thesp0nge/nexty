require 'nexty/config'
module Nexty
  class Connector
    
    attr_reader :nsc, :config
    def initialize(file)
      @config = Nexty::Config.instance.read(file)
      @nsc = Nexpose::Connection.new(@config["config"]["host"], 
                                     @config["config"]["user"],
                                     @config["config"]["pass"],
                                     @config["config"]["port"])
    end
  end
end
