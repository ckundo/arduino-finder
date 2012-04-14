require 'radar'

class StoresController < ApplicationController
  def index
    @zip = Store.extract_zip_from_params!(params)
    
    Radar::RadioShack.near(@zip)
    @stores = Store.near(@zip)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end 
  end
end
