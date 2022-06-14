class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2]
  
  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar
 
  private
    
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end

    def self.from_omniauth(auth)
      p "holiholiholi"
      p auth.info.name.split(" ")
      p "holaholahola"
      p auth.info
      name_split = auth.info.name.split(" ")
      user = User.where(email: auth.info.email).first
      user ||= User.create!(name:auth.info.name, username:auth.info.email.split("@").first+rand(1000).to_s, provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20], img_auth: auth.info.image)
        user
    end
end
