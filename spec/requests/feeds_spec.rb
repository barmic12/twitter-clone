require 'rails_helper'

RSpec.describe 'Feeds', type: :request do
  describe 'GET #index' do

    context 'when user is logged' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'returns success status' do
        get feeds_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged' do
      it 'returns redirected status' do
        get feeds_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET #tag(tag_name)' do
    context 'when user is logged' do
      it 'returns success status' do
        get "/feeds/tag/#{Faker::Lorem.word}"
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged' do
      it 'returns success status' do
        get "/feeds/tag/#{Faker::Lorem.word}"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
