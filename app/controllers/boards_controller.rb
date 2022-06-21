class BoardsController < ApplicationController
  def index
    @users = User.all
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.received_requests
    @notifications = Notification.where(user_id:current_user.id)
  end

  def show
  end

  def edit

  end
end
