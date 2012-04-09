require 'spec_helper'

describe "Stores", :vcr do
  describe "GET /stores" do
    it "works! (now write some real specs)" do
      get stores_path
      response.status.should be(200)
    end
  end
end
