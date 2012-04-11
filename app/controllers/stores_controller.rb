require 'radar'

class StoresController < ApplicationController
  def index
    @zip = '10012'
    if !params[:latitude].blank? && !params[:longitude].blank?
      @zip = Geocoder.search("#{params[:latitude]},#{params[:longitude]}").first.postal_code
    elsif !params[:zip].blank?
      @zip = params[:zip]
    elsif !request.location.postal_code.blank? 
      @zip = loc.postal_code
    end
    
    Radar::RadioShack.near(@zip)
    @stores = Store.near(@zip)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end 
  end
end
