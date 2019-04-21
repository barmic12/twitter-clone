require 'rails_helper'

RSpec.feature 'Visitor signs up', type: :feature do
  let(:user) { build(:user) }
  scenario 'with valid email, username, password' do
    sign_up_with user.email, user.username, user.password, user.password

    expect(page).to have_content('Sign out')
  end

  scenario 'with blank email' do
    sign_up_with '', user.username, user.password, user.password

    expect(page).to have_content('Sign up')
  end

  scenario 'with blank username' do
    sign_up_with user.email, '', user.password, user.password

    expect(page).to have_content('Sign up')
  end

  scenario 'with invalid password confirmation' do
    invalid_password = "bad_#{user.password}"
    sign_up_with user.email, user.username, user.password, invalid_password

    expect(page).to have_content('Sign up')
  end

  def sign_up_with(email, username, password, password_confirmation)
    visit new_user_registration_path
    fill_in :user_email, with: email
    fill_in :user_username, with: username
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password_confirmation
    find('[name=commit]').click
  end
end
