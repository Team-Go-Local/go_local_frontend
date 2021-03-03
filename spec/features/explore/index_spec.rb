require 'rails_helper'

describe 'Explore Landing Page' do
  it 'can see all excursions ordered by most recent date' do
    stub_omniauth
    user = create(:omniauth_mock_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    stub_request(:post, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}").to_return(status: 204)
    allow(DashboardFacade).to receive(:user_excursions).and_return([])

    visit root_path
    within('.login') { click_link }

    json_response = File.read('spec/fixtures/all_excursions.json')
    stub_request(:get, "https://go-local-be.herokuapp.com/api/v1/excursions").to_return(status: 200, body: json_response)
    
    click_button "Explore"

    expect(current_path).to eq('/explore')
    expect(page).to have_button("Search by City")

    json_data = JSON.parse(json_response, symbolize_names: true)

    expect(page).to have_content(json_data[:data].first[:attributes][:title])
    expect(page).to have_content(json_data[:data].first[:attributes][:description])
    expect(page).to have_button("Save")
  end
end