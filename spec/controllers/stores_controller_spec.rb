require 'spec_helper'

describe StoresController do
  describe 'GET index' do
    let(:store) { stub_model(Store) }

    before(:each) do
      Radar::RadioShack.stub(:near) { [store] }
      Store.stub(:near) { [store] }
    end

    it 'it assigns the zip code for a user specified set of coordinates' do
      get :index, :latitude => "35.0522", :longitude => "-118.2428"
      assigns(:zip).should eql("93501")
    end

    it 'it assigns the zip code for a user specified zip code' do
      get :index, :zip => "91105"
      assigns(:zip).should eql("91105")
    end

    it 'sets a default zipcode if none is specified' do
      get :index
      assigns(:zip).should eql("10012")
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
