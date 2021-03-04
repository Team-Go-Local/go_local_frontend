require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'Favorited Excursions' do
    it 'can see all the excursions I have favorited' do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(DashboardFacade).to receive(:user_excursions).and_return([])
      
      favorites = build_list(:excursion, 4)
      
      allow(DashboardFacade).to receive(:favorited_excursions).and_return(favorites)

      visit dashboard_path

      expect(page).to have_content('Favorites/Saved Excursions')

      within "#saved_excursion" do
        expect(page).to have_content('My Favorite Excursions')
        expect(page).to have_content(favorites[0].title)
        expect(page).to have_content(favorites[0].description)
      end

      within "#my_excursions" do
        expect(page).to_not have_content(favorites[0].title)
        expect(page).to_not have_content(favorites[0].description)
      end
    end
  end
end