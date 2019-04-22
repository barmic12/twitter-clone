class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  has_many :posts

  has_many :follower_relationships,
           class_name: 'Follow',
           foreign_key: 'following_id'
  has_many :followers, through: :follower_relationships

  has_many :following_relationships,
           class_name: 'Follow',
           foreign_key: 'follower_id'
  has_many :following, through: :following_relationships
end
