require 'rails_helper'

RSpec.feature 'User can see posts on feeds', type: :feature do
  let(:user) { create(:user) }
  let(:following1) { create(:user) }
  let(:following2) { create(:user) }
  before do
    create(:follow, follower: user, following: following1)
    create(:follow, follower: user, following: following2)
    sign_in user
  end
  scenario 'with 5 posts' do
    2.times { create(:post, user: following1) }
    3.times { create(:post, user: following2) }
    visit feeds_path
    expect(page).to have_selector('div.post-container', count: 5)
  end
  scenario 'with 8 posts' do
    2.times { create(:post, user: following1) }
    6.times { create(:post, user: following2) }
    visit feeds_path
    expect(page).to have_selector('div.post-container', count: 8)
  end
end
