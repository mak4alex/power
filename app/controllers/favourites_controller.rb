class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  
  
  def create
    current_user.add_favourite(@post)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end


  def destroy
    current_user.remove_favourite(@post)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  
  private
    
    def set_post
      @post = Post.find(params[:id])
    end
  
end
