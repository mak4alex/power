class HelpsController < ApplicationController
  
  def new
    @help = Help.new
  end
  
  def create
    @help = Help.new(help_params)
    
    if @help.save
      SendEmailJob.perform_later(@help)
      redirect_to root_url, flash: { success: 'Help message was successfully sent.' }
    else
      flash.now[:error] = 'Help message was not sent.'
      render :new
    end
  end
  
  private
    def help_params
      params.require(:help).permit(:email, :name, :topic, :body, :attachment)
    end
end