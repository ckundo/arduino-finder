require 'spec_helper'

describe Store, :vcr do
  let(:attributes) do
    {
      :name => 'Some store',
      :address1 => '123 Main Street',
      :address2 => '',
      :city => 'Springfield',
      :state => 'MA',
      :zip => '03019'
    }
  end

  let(:store) do
    Store.create!(attributes)
  end

  let(:location) do
    {
      :latitude => 74.01,
      :longitude => -110.01
    }
  end

  describe '.full_address' do
    subject { store }

    its(:full_address) do
      should == "123 Main Street, , Springfield, MA 03019"
    end
  end

  describe '.extract_zip_from_params' do
    subject { Store.extract_zip_from_params!(params) }
    let(:zip) { '11231' }
    context 'params are a zipcode' do
      let(:params) do 
        { :location => { :zip => zip } }
      end 
      it { should == zip }
    end
    context 'params are coordinates' do
      let(:params) do 
        { :location => {:latitude => 40.677280, :longitude => -74.009} }
      end
      it { should == zip }
    end
    context 'params are garbage' do
      let(:params) do
        { :location => {:foo => nil } }
      end
      it do
        expect { subject }.to raise_error 
      end
    end
  end
end
