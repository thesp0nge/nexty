require 'spec_helper'

describe "Site loading from file " do
  it "should return an empty array if the file doesn't exist" do
    a = Nexty::Sites.load_from_file('./spec/data/sites_non_existant.txt')
    a.should be_empty
    a.should_not be_nil
  end

  it "should return an array with site names" do
    a = Nexty::Sites.load_from_file('./spec/data/sites.txt')
    a.should_not be_empty
    a.should include 'a'
  end
end
