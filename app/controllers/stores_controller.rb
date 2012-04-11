require 'radar'

class StoresController < ApplicationController
  def index
    if !params[:latitude].blank? && !params[:longitude].blank?
      @zip = Geocoder.search("#{params[:latitude]},#{params[:longitude]}").first.postal_code
      @stores = Store.near(@zip)
    else
      loc = request.location
      @zip = (!loc || loc.postal_code.blank?) ? '10012' : loc.postal_code
      coords = Geocoder.search(@zip).first.coordinates 
    end
    
    Radar::RadioShack.near(@zip)
    @stores = Store.near(@zip)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end 
  end
end
