class ImagesController < ApplicationController
  before_action :authenticate_user!
  
  
  def create
    image = Image.new(file: params[:file])
    if image.save
      render json: image.prepare_json, status: :created
    else
      render json: image.errors, status: :unprocessable_entity
    end
  end
  

end