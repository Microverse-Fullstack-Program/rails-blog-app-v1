class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to user_post_path(user_id: @comment.user_id, id: @comment.post_id),
                  notice: 'Comment was successfully created.'
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post

    if can? :destroy, @comment
      @comment.destroy
      redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully deleted.'
    else
      redirect_to user_posts_path(current_user), alert: 'You are not authorized to delete this comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :text)
  end
end
