class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :user_like, optional: true, class_name: 'User', foreign_key: 'user_like_id'
end
