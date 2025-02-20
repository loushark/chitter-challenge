require './app.rb'
require 'spec_helper'

feature 'Chitter homepage' do
  before do
    ensure_logout
  end
  scenario 'homepage has a chitter header' do
    visit '/'
    expect(page).to have_content 'Chitter'
  end
end

feature 'sign up to chitter' do
  before do
    ensure_logout
  end
  scenario 'a user can click a link to sign up' do
    click_link 'Sign Up'
    expect(page).to have_content 'Sign up to Chitter'
  end

  scenario 'user can fill in user information to sign up' do
    sign_up_fill_and_submit
    expect(page).to have_content 'You are signed in as'
  end

  scenario 'when signed in username and logout link is shown on peeps page' do
    sign_up_fill_and_submit
    expect(page).to have_content 'signed in as loushark'
    expect(page).to have_link 'Logout'
  end
end

feature 'login' do
  before do
    ensure_logout
  end
  scenario ' a user can click a link to login' do
    visit '/peeps'
    click_link 'Login'
    expect(page).to have_content 'Login to Chitter'
  end

  scenario 'user can fill in user information to log in' do
    login
    expect(page).to have_content 'You are signed in as loushark'
  end

end

feature 'logout' do
  before do
    ensure_logout
  end
  scenario 'user can click a link to logout' do
    login
    visit '/peeps'
    expect(page).to have_link 'Logout'
  end

  scenario 'user is logged out' do
    login
    click_link 'Logout'
    expect(page).to have_link 'Sign Up'
    expect(page).to have_link 'Login'
    expect(page).to have_content 'You are a Guest'
  end
end

feature 'peeps page' do
  before do
    ensure_logout
  end
  scenario 'user can view all peeps' do
    fill_test_database
    visit '/peeps'
    expect(page).to have_content 'Peeps'
    expect(page).to have_content 'I have eaten way too many brownies! Help!'
    expect(page).to have_content 'loushark'
  end
end

feature 'add a peep' do
  before do
    ensure_logout
  end
  scenario 'user can click a link to add a peep' do
    login
    expect(page).to have_link 'Add Peep'
  end

  scenario 'logged in user can write a new peep and submit it to the peeps page' do
    login
    click_link 'Add Peep'
    fill_in 'new_peep', with: 'Brownies are awesome!'
    click_button 'Add Peep'
    expect(page).to have_content 'Brownies are awesome!'
  end
end

feature 'view peeps as a guest' do
  scenario 'guests can view peeps without sign up or login' do
    login
    click_link 'Logout'
    expect(page).to have_link 'Sign Up'
    expect(page).to have_link 'Login'
    expect(page).to have_content 'You are a Guest'
  end
end
