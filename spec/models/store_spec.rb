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

  describe '.full_address' do
    subject { store }

    its(:full_address) do
      should == "123 Main Street, , Springfield, MA 03019"
    end
  end

  describe '.find_or_create_by_location!' do
    subject { Store.find_or_create_by_location!(location) }

    context 'with lat and lng' do
      let(:location) do
        {
          :latitude => 74.01,
          :longitude => -110.01
        }
      end
      
      context 'store exists' do
        it do
          puts Store.count
        end
        its (:zip) { should == attributes.fetch(:zip) }
      end
    end
  end
end
