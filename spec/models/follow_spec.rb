require 'rails_helper'

RSpec.describe Follow, type: :model do

  it 'has valid factory' do
    expect(build(:follow)).to be_valid
  end

  let(:follow) { build(:follow) }

  describe 'ActiveModel validations' do
    it {
      is_expected.to validate_uniqueness_of(:follower_id)
        .scoped_to(:following_id).case_insensitive
    }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:follower) }
    it { is_expected.to belong_to(:following) }
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column(:follower_id).of_type(:integer) }
    it { is_expected.to have_db_column(:following_id).of_type(:integer) }
  end
end
