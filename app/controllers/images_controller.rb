class ImagesController < ApplicationController
  before_action :authenticate_user!
  
  
  def create
    image = Image.new(file: params[:file])
    if image.save
      render json: image.to_json(only: [:id, :alt], methods: [:url_medium]), status: :created
    else
      render json: image.errors, status: :unprocessable_entity
    end
  end
  

end