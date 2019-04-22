class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, length: { in: 3..300 }
end
