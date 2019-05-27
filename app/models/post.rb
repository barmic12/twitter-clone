class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { in: 3..500 }

  scope :subscribed, ->(following) { where user_id: following}

  acts_as_taggable_array_on :tags
end
