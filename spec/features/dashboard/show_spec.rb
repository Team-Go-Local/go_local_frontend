require 'rails_helper'

RSpec.describe 'Show' do
  describe 'happy path' do
    it 'can see a basic traveler and local boards' do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(DashboardFacade).to receive(:user_excursions).and_return([])
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
      visit dashboard_path

      within '#traveller' do
        expect(page).to have_content('Traveller')
        expect(page).to have_content('Favorites/Saved Excursions')
      end
      within '#local' do
        expect(page).to have_content('Local')
        expect(page).to have_link('Add Excursion')
      end
    end

    it 'shows excursions created by the user' do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      excursions = build_list(:excursion, 3)
      allow(DashboardFacade).to receive(:user_excursions).and_return(excursions)
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])

      visit dashboard_path

      within '#my_excursions' do
        excursions.each do |excursion|
          expect(page).to have_content(excursion.title)
        end
        expect(page).to have_link('Delete', count: 3)
        expect(page).to have_link('Edit', count: 3)
      end
    end
  end

  describe 'navigation' do
    before(:each) do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(DashboardFacade).to receive(:user_excursions).and_return([])
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
    end

    it 'links to the new excursion page' do
      visit dashboard_path

      click_link('Add Excursion')

      expect(current_path).to eq(excursions_new_path)
    end

    it 'links to the edit excursion page' do
      excursion = build(:excursion)
      allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])
      allow(ExcursionsFacade).to receive(:get_excursion).and_return(excursion)

      visit dashboard_path

      click_link('Edit')

      expect(current_path).to eq(excursions_edit_path(excursion.id))
    end

    it 'links to the explore page' do
      allow(ExcursionsFacade).to receive(:list_all_excursions).and_return([])
      visit dashboard_path

      within('#explore') do
        click_link('Explore')
      end

      expect(current_path).to eq(explore_path)
    end
  end

  describe 'sad path' do
    it 'displays a message if the call to BE to find user\'s excursions fails' do
      user = create(:omniauth_mock_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])

      stub_request(:get, "https://go-local-be.herokuapp.com/api/v1/users/1/excursions").to_return(status: 500)

      visit dashboard_path

      expect(page).to have_content("We're sorry, we were unable to locate your excursions. Please try again later.")
    end
  end
end
