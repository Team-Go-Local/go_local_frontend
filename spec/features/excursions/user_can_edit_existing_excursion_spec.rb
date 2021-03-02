require 'rails_helper'

describe 'Excursion Edit' do
  describe 'happy path' do
    xit 'can edit an excursion and be redirected to dashboard' do
      json_response = File.read('spec/fixtures/excursion_response.json')
      stub_request(:patch, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/123/excursions/update?description=Sample%20Description&location=Denver,%20CO&title=Sample%20Title&user_id=123")
        .to_return(status: 200, body: json_response)

      user = instance_double('User')
      allow(user).to receive(:name).and_return('Yesi')
      allow(user).to receive(:id).and_return(123)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      stub_omniauth
      within('.login') { click_link }

      #within the excursion block
      data = JSON.parse(json_response, symbolize_names: true)

      # ExcursionDetails.new(place_id: 1, name: 'casa bonita') #this is in place of having to pass the follwoing below
      ExcursionDetails.new({data: {attributes: {title: "casa bonita", location: "123 ave, lakewood co 80214", place_id: 12}}})

      click_button "Edit"

      fill_in :title, with: "Sample Title"
      fill_in :description, with: "Sample Description"
      fill_in :location, with: "Broomfiled, CO"

      click_button "Update Excursion"

      expect(current_path).to eq(dashboard_path)
      within('#local') do
        expect(page).to have_content("Broomfield, CO")
      end
    end
  end
end
