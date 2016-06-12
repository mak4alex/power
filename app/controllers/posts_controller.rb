class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :vote, :favourites]
  before_action :set_post, only: [:edit, :update, :destroy, :vote]
  before_action :set_post_with_comments, only: [:show]
  before_action :update_visits, only: [:show]
  before_action :add_user_id_to_params, only: [:index]
  

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.fetch(params)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
  def vote
    @post.vote_by voter: current_user, vote_weight: vote_weight
    render json: { weighted_average: @post.weighted_average }
  end
  
  def favourites
    @posts = current_user.favourite_posts.page(params[:page]).per(params[:per_page])
    render :index
  end
  

  private

    def set_post
      @post = Post.find(params[:id])
    end
    
    def add_user_id_to_params
      params[:user_id] = current_user.id if user_signed_in?
    end
    
    def set_post_with_comments
      @post = Post.includes(:comments).find(params[:id])
    end
    
    def update_visits
      Post.increment_counter(:visits_count, @post.id)
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def vote_weight
      weight =  params[:weight].to_i.abs
      weight = Post::MAX_WEIGHT if weight > Post::MAX_WEIGHT
      weight
    end
end
