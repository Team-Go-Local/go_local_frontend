require 'rails_helper'

RSpec.describe 'Show' do
  describe 'happy path' do
    it 'can see a basic traveler and local boards' do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(DashboardFacade).to receive(:user_excursions).and_return([])

      visit dashboard_path

      within '#traveller' do
        expect(page).to have_content('Traveller')
        expect(page).to have_content('Favorites/Saved Excursions')
      end
      within '#local' do
        expect(page).to have_content('Local')
        expect(page).to have_button('Add Excursion')
      end
    end

    it 'shows excursions created by the user' do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      excursions = build_list(:excursion, 3)
      allow(DashboardFacade).to receive(:user_excursions).and_return(excursions)

      visit dashboard_path

      within '#my_excursions' do
        excursions.each do |excursion|
          expect(page).to have_content(excursion.title)
        end
        expect(page).to have_button('Delete', count: 3)
        expect(page).to have_button('Edit', count: 3)
      end
    end
  end

  describe 'navigation' do
    before(:each) do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(DashboardFacade).to receive(:user_excursions).and_return([])
    end

    it 'links to the new excursion page' do
      visit dashboard_path

      click_button('Add Excursion')

      expect(current_path).to eq(excursions_new_path)
    end

    it 'links to the edit excursion page' do
      excursion = build(:excursion)
      allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])
      allow(ExcursionsFacade).to receive(:get_excursion).and_return(excursion)

      visit dashboard_path

      click_button('Edit')

      expect(current_path).to eq(excursions_edit_path(excursion.id))
    end

    it 'links to the explore page' do
      allow(ExcursionsFacade).to receive(:list_all_excursions).and_return([])
      visit dashboard_path

      click_button('Explore')

      expect(current_path).to eq(explore_path)
    end
  end
end
