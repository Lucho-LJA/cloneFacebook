class BoardsController < ApplicationController
  def index
    @users = User.all
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.received_requests
    @notifications = Notification.where(user_id:current_user.id)
    @post = Post.new
  end

  def show
    @post = Post.new
    @user = User.find(params[:format])
  end

  def edit

  end
  def like_person
    if Notification.where(user_id:current_user.id,notice_type:"like-user",seen:false).exists?
      @notification = Notification.where(user_id:current_user.id,notice_type:"like-user",seen:false).first
      @notification.update(seen:true)
    end
    redirect_to root_path
  end
end
