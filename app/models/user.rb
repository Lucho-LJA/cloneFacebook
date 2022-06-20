class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2]
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_sent, class_name: 'Friendship', 
            foreign_key: 'sent_by_id', 
            inverse_of: 'sent_by', 
            dependent: :destroy
  has_many :friend_request, class_name: 'Friendship', 
            foreign_key: 'sent_to_id', 
            inverse_of: 'sent_to', 
            dependent: :destroy
  
  has_many :friends, -> { merge(Friendship.friends) }, 
            through: :friend_sent, source: :sent_to
  has_many :pending_requests, -> { merge(Friendship.not_friends) }, 
            through: :friend_sent, source: :sent_to
  has_many :received_requests, -> { merge(Friendship.not_friends) },
            through: :friend_request, source: :sent_by

  has_many :notifications, dependent: :destroy
  
  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar
  validate :avatar_size_validation
 
  # Returns all posts from this user's friends and self
  def friends_and_own_posts
    myfriends = friends
    our_posts = []
    myfriends.each do |f|
      f.posts.each do |p|
        our_posts << p
      end
    end
    posts.each do |p|
      our_posts << p
    end
    our_posts
  end

  private
    
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end

    def self.from_omniauth(auth)
      p "holiholiholi"
      p auth.info.name.split(" ")
      p "holaholahola"
      p auth.info
      #user = User.where(email: auth.info.email).first
      #user ||= User.create!(name:auth.info.name, username:auth.info.email.split("@").first+rand(1000).to_s, provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20], img_auth: auth.info.image)
      #  user
      """
      #Use to only login one time and never update 
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name   # assuming the user model has a name
        user.img_auth = auth.info.image # assuming the user model has an image
        user.avatar = auth.info.image
        user.avatar_cache = ""
        # If you are using confirmable and the provider(s) you use validate emails, 
        # uncomment the line below to skip the confirmation emails.
        user.skip_confirmation!
      end
      """
      #Use to update data of user each he/she log in
      user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.img_auth = auth.info.image # assuming the user model has an image
      user.username = auth.info.email.split("@").first+rand(1000).to_s unless user.id.present?
      user.skip_confirmation!
      user.save
      user
    end
end
