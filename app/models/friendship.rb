class Friendship < ApplicationRecord
  belongs_to :sent_to, class_name: 'User', foreign_key: 'sent_to_id'
  belongs_to :sent_by, clas_name: 'User', foreign_key: 'sent_ny_id'
end
