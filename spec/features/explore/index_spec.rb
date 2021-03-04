require 'rails_helper'

describe 'Explore Landing Page' do
  it 'can see all excursions ordered by most recent date' do
    stub_omniauth
    user = create(:omniauth_mock_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    stub_request(:post, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}").to_return(status: 204)
    allow(DashboardFacade).to receive(:user_excursions).and_return([])
    allow(DashboardFacade).to receive(:favorited_excursions).and_return([])

    visit root_path
    within('.login') { click_link }

    json_response = File.read('spec/fixtures/all_excursions.json')
    stub_request(:get, "https://go-local-be.herokuapp.com/api/v1/excursions").to_return(status: 200, body: json_response)
    
    within('#explore') do
      click_link "Explore"
    end

    expect(current_path).to eq('/explore')
    expect(page).to have_button("Search by City")

    json_data = JSON.parse(json_response, symbolize_names: true)

    expect(page).to have_content(json_data[:data].first[:attributes][:title])
    expect(page).to have_link(json_data[:data].first[:attributes][:title])
    expect(page).to have_content(json_data[:data].first[:attributes][:description])
    expect(page).to have_button("Save")
  end

  describe 'sad path' do
    it 'displays a message if the call to BE to find excursions fails' do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      stub_request(:get, "https://go-local-be.herokuapp.com/api/v1/excursions").to_return(status: 500)
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
      visit explore_path

      expect(page).to have_content("We're sorry, we were unable to locate the content you requested. Please try again later.")
    end
  end
end
