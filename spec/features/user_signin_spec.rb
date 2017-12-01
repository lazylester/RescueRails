require 'rails_helper'

feature 'Sign in as Admin', js: true do
  scenario 'Valid User' do
    admin = create(:user)

    visit '/users/sign_in'
    fill_in('user_email', with: admin.email)
    fill_in('user_password', with: admin.password)
    click_button('Sign in')
    expect(page).to have_no_content('Invalid')
  end
end
