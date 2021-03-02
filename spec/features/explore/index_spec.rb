require 'rails_helper'

describe 'Explore Landing Page' do
  it 'can see all excursions ordered by most recent date' do
    stub_omniauth
    user = create(:omniauth_mock_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    excursion_list = build_list(:excursion, 3)

    stub_request(:post, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/#{user.id}").to_return(status: 204)

    visit root_path
    within('.login') { click_link }

    json_response = File.read('spec/fixtures/excursion_response.json')
    stub_request(:get, "https://tranquil-refuge-53915.herokuapp.com/api/v1/excursions").to_return(status: 200, body: json_response)
    
    

    click_button "Explore"

    expect(current_path).to eq('/explore')
    expect(page).to have_button("Search by City")
    # within('section.excursion-list') do
    expect(page).to have_content(excursion_list.title)
    expect(page).to have_content(excursion_list.description)
    expect(page).to have_button("Save")
      # we need to see a list of excursions from earlier
    # end
  end
end