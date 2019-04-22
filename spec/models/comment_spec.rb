require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has valid factory' do
    expect(build(:comment)).to be_valid
  end

  let(:comment) { build(:comment) }

  describe 'ActiveModel validations' do
    it { expect(comment).to validate_length_of(:body).is_at_least(3) }
    it { expect(comment).to validate_length_of(:body).is_at_most(300) }
  end

  describe 'ActiveRecord associations' do
    it { expect(comment).to belong_to(:user) }
    it { expect(comment).to belong_to(:post) }
    it { expect(comment).to have_many(:likes) }
  end

  describe '#destroy' do
    it 'deletes releated likes' do
      like = create(:like, :comment)
      comment_to_destroy = like.likeable
      expect{ comment_to_destroy.destroy }.to change { Like.count }.by(-1)
    end
  end
end
