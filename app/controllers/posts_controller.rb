class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @current_user = current_user
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_posts_path, notice: 'Post was successfully created.'
    else
      render 'new'
    end
  end
def destroy
    @post = Post.find(params[:id])

    if can? :destroy, @post
      @post.destroy
      redirect_to "/users/#{current_user.id}/posts", notice: 'Successfully deleted.'
    else
      redirect_to user_post_path(@post.author_id, @post), alert: 'Unauthorized action.'
    end
  end
  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
