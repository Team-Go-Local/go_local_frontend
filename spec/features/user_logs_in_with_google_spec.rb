require 'rails_helper'

RSpec.describe "user logs in", type: :feature do
  it 'can log in using omniauth' do
    allow(DashboardFacade).to receive(:user_excursions).and_return([])
    allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
    user_count = User.count

    expect(user_count).to eq(0)

    stub_omniauth
    user = create(:omniauth_mock_user)
    stub_request(:post, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}").to_return(status: 204)

    visit root_path
    within('.login') { click_link }

    user_count = User.count
    expect(user_count).to eq(1)

    expect(page).to have_content("Welcome, #{user.name}")
    expect(current_path).to eq(dashboard_path)
  end
  it 'logs a returning user in via google mock' do
    allow(DashboardFacade).to receive(:user_excursions).and_return([])
    allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
    stub_omniauth

    user = create(:omniauth_mock_user)
    stub_request(:post, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}")
    user_count = User.count

    expect(user_count).to eq(1)

    visit root_path
    within('.login') { click_link }
    user_count = User.count

    expect(user_count).to eq(1)
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{user.name}")
  end
  it 'logs a returning user out' do
    allow(DashboardFacade).to receive(:user_excursions).and_return([])
    allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
    stub_omniauth
    user = create(:omniauth_mock_user)

    stub_request(:post, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}")

    user_count = User.count

    expect(user_count).to eq(1)

    visit root_path
    within('.login') { click_link }

    user_count = User.count

    expect(user_count).to eq(1)
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{user.name}")

    click_link 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).not_to have_content("Logout")
  end
end
