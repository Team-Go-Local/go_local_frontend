require 'rails_helper'

RSpec.describe "user logs in", type: :feature do
  it 'can log in using omniauth' do
    user_count = User.count
    expect(user_count).to eq(0)
    stub_omniauth

    visit root_path
    click_link 'Login with Google'

    user_count = User.count
    expect(user_count).to eq(1)

    user = User.first
    expect(page).to have_content("Welcome, #{user.name}")
    expect(current_path).to eq(dashboard_path)
  end
  it 'logs a returning user in via google mock' do
    stub_omniauth
    user = create(:omniauth_mock_user)
    user_count = User.count
    expect(user_count).to eq(1)
    visit root_path
    click_link 'Login with Google'
    user_count = User.count
    expect(user_count).to eq(1)
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{user.name}")
  end
  it 'logs a returning user out' do
    stub_omniauth
    user = create(:omniauth_mock_user)
    user_count = User.count
    expect(user_count).to eq(1)
    visit root_path
    click_link 'Login with Google'
    user_count = User.count
    expect(user_count).to eq(1)
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{user.name}")
    click_button 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).not_to have_content("Logout")
  end
end
