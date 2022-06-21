class Post < ApplicationRecord
  mount_uploader :img_url, ImgUrlUploader
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates_integrity_of  :img_url
  validates_processing_of :img_url
  validate :img_url_size_validation

  private
  def img_url_size_validation
    errors[:img_url] << "should be less than 500KB" if img_url.size > 0.5.megabytes
  end

end
