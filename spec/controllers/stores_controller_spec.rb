require 'spec_helper'

describe StoresController do
  describe 'GET index', :vcr do
    let(:store) { stub_model(Store) }

    before(:each) do
      Radar::RadioShack.stub(:near) {[store]}
      Store.stub(:near) { [store] }
    end

    it 'should find stores for a specified location' do
      get :index, { :latitude => "35.0522", :longitude => "118.2428" }
      Geocoder.should_receive(:search).with("35.0522,118.2428")
      assigns(:zip).should eql("91105")
    end

    it 'sets a default location for the user' do
      get :index
      assigns(:zip).should eql({"latitude" => 40.7250632 , "longitude" =>  -73.9976946 })
    end
    
    it 'assigns nearby stores to locations' do
      get :index
      response.should be_success
      assigns(:stores).should eq([store])
    end
    
    it 'should render the proper view' do
      get :index, :format => 'html'
      response.should render_template('stores/index')
    end
  end
end
