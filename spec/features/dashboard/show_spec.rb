require 'rails_helper'

RSpec.describe 'Show' do
  describe 'happy path' do
    it 'can see a basic traveler and local boards' do
      visit root_path
      stub_omniauth
      click_link 'Login with Google'

      visit dashboard_path
      within '#traveller' do
        expect(page).to have_content('Traveller')
        expect(page).to have_content('Favorites/Saved Excursions')
      end
      within '#local' do
        expect(page).to have_content('Local')
        expect(page).to have_button('Add Exercursions')
        expect(page).to have_button('Delete')
        expect(page).to have_button('Edit')
      end
    end
  end
end
