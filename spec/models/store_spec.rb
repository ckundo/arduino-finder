require 'spec_helper'

describe Store, :vcr do
  describe '.full_address' do
    it 'should be a valid address' do
      store = Store.create!(:address1 => '123 Main Street', 
                            :address2 => '', :city => 'Springfield', :state => 'MA', :zip => '03019')
      store.full_address.should be_an_instance_of String    
    end
  end
end
