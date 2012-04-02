require 'radar'
class StoresController < ApplicationController
  def index
    loc = request.location
    default = loc.postal_code.empty? ? '10012' : loc.postal_code
    zip = params['zip'] || default
    coords = Geocoder.search(zip).first.coordinates #.first.data.fetch('geometry').fetch('location') if geo.empty?
    @lat = coords[0]
    @lng = coords[1]
    Radar::Shack.scan(zip)
    @locations = Store.near(zip)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end 
  end
end
