require 'rails_helper'

RSpec.describe Post, type: :model do

  it 'has valid factory' do
    expect(build(:post)).to be_valid
  end

  let(:post) { build(:post) }

  describe 'ActiveModel validations' do
    it { expect(post).to validate_presence_of(:body) }
    it { expect(post).to validate_length_of(:body).is_at_least(3) }
    it { expect(post).to validate_length_of(:body).is_at_most(500) }
  end

  describe 'ActiveRecord associations' do
    it { expect(post).to belong_to(:user) }
    it { expect(post).to have_many(:comments) }
    it { expect(post).to have_many(:likes) }
  end

  describe '#destroy' do
    it 'deletes releated likes' do
      like = create(:like, :post)
      post_to_destroy = like.likeable
      expect{ post_to_destroy.destroy }.to change { Like.count }.by(-1)
    end
  end

  describe 'Scopes' do
    describe 'subscribed' do
      let(:user) { create(:user) }
      before do
        following1 = create(:user)
        following2 = create(:user)
        create(:follow, follower: user, following: following1)
        create(:follow, follower: user, following: following2)
        create(:post, user: following1)
        create(:post, user: following2)
      end
      it 'returns 2 posts' do
        subscribed_users_ids = user.following.ids
        expect(Post.subscribed(subscribed_users_ids).count).to eq(2)
      end
    end
  end
end
