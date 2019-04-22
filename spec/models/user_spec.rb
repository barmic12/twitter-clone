require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  it 'has valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe 'ActiveModel validations' do
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_presence_of(:username) }
  end

  describe 'ActiveRecord associations' do
    it {expect(user).to have_many(:posts) }
  end
end
