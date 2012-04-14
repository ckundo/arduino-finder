require 'spec_helper'

feature "home", :acceptance, :js do
  example 'has map' do
    visit '/'
  end
end
