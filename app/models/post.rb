class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :body, presence: true
  validates :body, length: { in: 3..500 }
end
