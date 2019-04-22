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
end
