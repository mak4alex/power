class CommentsController < ApplicationController
  before_action :comment_params, only: [:create]
  
  def new
    @comment = Comment.new(post_id: params[:post_id], parent_id: params[:parent_id])
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @comment = Comment.new(comment_params)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(params[:post_id]), notice: 'Comment was successfully created.' }
        format.js { @comments = Post.find(params[:post_id]).comments.hash_tree }
      else
        format.html { redirect_to post_url(params[:post_id]), 
          alert: "Error. #{@comment.errors.full_messages.join('. ')}" }
        format.js
      end
    end
  end
  

  private
    
    def comment_params
      params.require(:comment).permit(:author, :body, :post_id, :parent_id)
    end

end