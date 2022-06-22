class CommentsController < ApplicationController
  include ApplicationHelper
  def new
    @comment = Comment.new
  end
  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if Notification.where(user_id:current_user.id,notice_id:params[:id],notice_type:"comment",seen:false).exists?
      @notification = Notification.where(user_id:current_user.id,notice_id:params[:id],notice_type:"comment",seen:false).first
      @notification.update(seen:true)
    end
    redirect_to post_path(@post)
  end
  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:comment][:post_id])
    if @comment.save
      @notification = new_notification(@post.user, @comment.id, 
                                      'comment')
      @notification.save
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find(params[:id])
    return unless current_user.id == @comment.user_id
    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_back(fallback_location: root_path)
  end
  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
