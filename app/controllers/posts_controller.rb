class PostsController < ApplicationController
  include ApplicationHelper
  def index
    @our_posts = current_user.friends_and_own_posts
  end

  def show
    @post = Post.find(params[:id])
    if Notification.where(user_id:current_user.id,notice_id:params[:id],notice_type:"like-post",seen:false).exists?
      @notification = Notification.where(user_id:current_user.id,notice_id:params[:id],notice_type:"like-post",seen:false).first
      @notification.update(seen:true)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    return unless current_user.id == @post.user_id

    @post.destroy
    #flash[:success] = 'Post deleted'
    redirect_back(fallback_location: root_path)
  end
  
  private
  def posts_params
    params.require(:post).permit(:content, :img_url)
  end
end
