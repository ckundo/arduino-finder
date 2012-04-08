require 'radar'

class StoresController < ApplicationController
  def index
    loc = request.location
    default = loc.postal_code.empty? ? '10012' : loc.postal_code
    zip = params['zip'] || default

    coords = Geocoder.search(zip).first.coordinates 
    @location = {:latitude => coords[0], :longitude => coords[1]}

    Radar::RadioShack.scan(zip)
    @stores = Store.near(zip)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end 
  end
end
