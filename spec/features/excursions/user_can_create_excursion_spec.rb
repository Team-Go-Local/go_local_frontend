require 'rails_helper'

describe 'Excursion Create' do
  describe 'happy path' do
    it 'can create an excursion and be redirected to dashboard' do
      json_response = File.read('spec/fixtures/excursion_response.json')
      stub_request(:get, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/123/excursions/create?description=Sample%20Description&location=Denver,%20CO&title=Sample%20Title&user_id=123")
        .to_return(status: 200, body: json_response)

      user = instance_double('User')
      allow(user).to receive(:name).and_return('Yesi')
      allow(user).to receive(:id).and_return(123)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      stub_omniauth
      within('.login') { click_link }

      click_button "Add Excursions"

      fill_in :title, with: "Sample Title"
      fill_in :description, with: "Sample Description"
      fill_in :location, with: "Denver, CO"

      click_button "Create Excursion"

      expect(current_path).to eq(dashboard_path)
      within('#local') do
        expect(page).to have_content("Denver, CO")
      end
    end
  end
  
  describe 'page contents' do
    it 'starts with no map and fields are not pre-filled' do
      user = User.create!(name: 'Yesi', email: 'yesi@example.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit excursions_new_path

      expect(page).to have_field(:place, placeholder: 'Enter a place')
      expect(page.find_field(:title).value).to be nil
      expect(page.find_field(:location).value).to be nil
      expect(page.find_field(:description).value).to be_empty
      expect(page).not_to have_css('#map')
    end
  end
end
