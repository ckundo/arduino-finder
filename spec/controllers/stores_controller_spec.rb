require 'spec_helper'

describe StoresController do
  describe 'GET index' do
    let(:store) { stub_model(Store) }

    before(:each) do
      Radar::RadioShack.stub(:near) { [store] }
      Store.stub(:near) { [store] }
    end

    it 'assigns a zip given lat/lng params' do
      get :index, :location => { 
        :latitude => "35.0522", 
        :longitude => "-118.2428"
      }
      assigns(:zip).should eql("93501")
    end

    it 'assigns a zip given zip param' do
      get :index, :location => {
        :zip => "91105"
      }
      assigns(:zip).should eql("91105")
    end

    it 'assigns a default zip' do
      get :index
      assigns(:zip).should eql("11231")
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
