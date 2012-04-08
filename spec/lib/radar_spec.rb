require "spec_helper"

describe Radar, :vcr do
  context "given a location" do
    it "should return a list of stores with arduino unos in stock" do
      location = 11231
      stores = Radar::RadioShack.scan(location)
      stores.should be_an_instance_of Array
      stores.should_not be_empty
      stores.each do |s| 
        s.should be_an_instance_of Store
        s.should_not be_nil
      end
    end
  end
end

