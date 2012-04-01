require 'radar'
class StoresController < ApplicationController
  def index
    locations = Radar::Shack.scan
    render json: locations
  end
end
