require 'spec_helper'

describe StoresController do
  describe 'GET index', :vcr do
    let(:store) { stub_model(Store) }

    before(:each) do
      Radar::RadioShack.stub(:scan) {[store]}
      #Geocoder.stub_chain(:search, :first, :coordinates).and_return([73.2,-132.2]) 
      #Geocoder.stub_chain(:search, :first, :postal_code).and_return('11231')
      Store.stub(:near) { [store] }
    end

    it 'sets a default location for the user' do
      get :index
      assigns(:location).should eql({"latitude" => 40.7250632 , "longitude" =>  -73.9976946 })
    end
    
    it 'should geolocate by zipcode' do
      get :index, { :zip => '91105' }
      assigns(:location)['latitude'].should < 40     
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
