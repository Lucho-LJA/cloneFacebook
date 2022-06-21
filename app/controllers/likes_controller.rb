class LikesController < ApplicationController
  include ApplicationHelper
  def create
    p params
    type = type_subject?(params)[0]
    @subject = type_subject?(params)[1]
    notice_type = "like-#{type}"
    
    return unless @subject
    if already_liked?(type)
      dislike(type)
    else
      @like = @subject.likes.build(user_id: current_user.id) if type != 'user'
      @like = @subject.likes.build(user_id: current_user.id, user_like_id: params[:board_id]) if type == 'user'
      if @like.save
        #flash[:success] = "#{type} liked!"
        @notification = new_notification(@subject.user, @subject.id,
                                         notice_type) if type != 'user'
        @notification = new_notification(@subject, @subject.id,
                                          notice_type) if type == 'user'
        @notification.save
      else
        flash[:danger] = "#{type} like failed!"
      end
      redirect_back(fallback_location: root_path)
    end
  end

  private
  
  def type_subject?(params)
    type = 'post' if params.key?('post_id')
    type = 'comment' if params.key?('comment_id')
    type = 'user' if params.key?('board_id')
    subject = Post.find(params[:post_id]) if type == 'post'
    subject = Comment.find(params[:comment_id]) if type == 'comment'
    subject = User.find(params[:board_id]) if type == 'user'
    [type, subject]
  end
  
  def already_liked?(type)
    result = false
    if type == 'post'
      result = Like.where(user_id: current_user.id,
                          post_id: params[:post_id]).exists?
    end
    if type == 'comment'
      result = Like.where(user_id: current_user.id,
                          comment_id: params[:comment_id]).exists?
    end
    if type == 'user'
      result = Like.where(user_id: current_user.id,
                          user_like_id: params[:board_id]).exists?
    end
    result
  end
  
  def dislike(type)
    @like = Like.find_by(post_id: params[:post_id]) if type == 'post'
    @like = Like.find_by(comment_id: params[:comment_id]) if type == 'comment'
    @like = Like.find_by(user_like_id: params[:board_id]) if type == 'user'
    return unless @like
    
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
