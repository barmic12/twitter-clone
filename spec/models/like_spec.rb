require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Factories' do
    it 'has valid factory for comment' do
      expect(build(:like, :comment)).to be_valid
    end

    it 'has valid factory for post' do
      expect(build(:like, :post)).to be_valid
    end
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:likeable) }
  end

  describe 'Database schema' do
    it { is_expected.to have_db_column(:likeable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:likeable_type).of_type(:string) }
  end

  describe '#destroy' do
    it 'deletes the like' do
      like = create(:like, :comment)
      expect { like.destroy }.to change { Like.count }.by(-1)
    end
  end
end
