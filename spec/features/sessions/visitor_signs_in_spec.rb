require 'rails_helper'

RSpec.feature 'Visitor signs in ', type: :feature do
  let(:user) { create(:user) }
  scenario 'with valid email and password' do
    sign_in_with user.email, user.password

    expect(page).to have_content('Sign out')
  end

  scenario 'with blank email' do
    sign_in_with '', user.password

    expect(page).to have_content('Log in')
  end

  scenario 'with invalid email' do
    invalid_email = "invalid_#{user.email}"
    sign_in_with invalid_email, user.password

    expect(page).to have_content('Log in')
  end

  scenario 'with blank password' do
    sign_in_with user.email, ''

    expect(page).to have_content('Log in')
  end


  scenario 'with invalid password' do
    invalid_password = "invalid_#{user.password}"
    sign_in_with user.email, invalid_password

    expect(page).to have_content('Log in')
  end

  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    find('[name=commit]').click
  end
end
