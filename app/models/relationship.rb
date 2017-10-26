class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validates :follower, presence: true
  validates :followed, presence: true

  scope :following_ids, (lambda do |user_id|
    select(:followed_id).where follower_id: user_id
  end)
end
