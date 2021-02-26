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
    save_and_open_page
    user = User.first
    expect(page).to have_content("Welcome, #{user.name}")
    expect(current_path).to eq(dashboard_path)
  end
end