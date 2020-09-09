class PagesController < ApplicationController
  def index
  end

  def create
    og_image_url = "http://www.google.com"


    
    render json: { og_image_url: og_image_url }
  end
end
