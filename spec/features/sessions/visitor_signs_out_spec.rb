require 'rails_helper'

RSpec.feature 'User signs out', type: :feature do
  let(:user) { create(:user) }

  scenario 'beeing logged in' do
    sign_in(user)
    find('a', text: 'Sign out').click

    expect(page).to have_content('Sign in')
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    find('[name=commit]').click
  end
end
