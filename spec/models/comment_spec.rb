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
  end
end
