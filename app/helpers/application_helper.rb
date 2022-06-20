module ApplicationHelper
  #Mothods to use the variables of default edit view register
  ####
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end
###

  # Methods to LIke
  ####
  # Checks whether a post, user or comment has already been liked by the 
  # current user returning either true or false
  def liked?(subject, type)
    result = false
    result = Like.where(user_id: current_user.id,
                          post_id: subject.id).exists? if type == 'post'
    result = Like.where(user_id: current_user.id,
                          comment_id: subject.id).exists? if type == 'comment'
    result = Like.where(user_id: current_user.id,
                          user_like_id: object.id).exists? if type == 'user'
    result
  end

  ####


  # methods to Noticfications
  ###
  # Returns the new record created in notifications table
  def new_notification(user, notice_id, notice_type)
    notice = user.notifications.build(notice_id: notice_id, notice_type: notice_type)
    notice
  end
  def notification_find(notice, type)
    return User.find(notice.notice_id) if type == 'friendRequest'
    return User.find(notice.notice_id) if type == 'like-user'
    return Post.find(notice.notice_id) if type == 'post'
    return Post.find(notice.notice_id) if type == 'comment'
    return Post.find(notice.notice_id) if type == 'like-post'
    return unless type == 'like-comment'
    comment = Comment.find(notice.notice_id)
    Post.find(comment.post_id)
  end
  ###
end
