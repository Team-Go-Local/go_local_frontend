require 'rails_helper'

describe 'Excursion Create' do
  describe 'happy path' do
    it 'can create an excursion and be redirected to dashboard' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(ExcursionsFacade).to receive(:create_excursion)

      excursion = instance_double("Excursion")
      allow(excursion).to receive(:title).and_return("Cabrini Bridge")
      allow(excursion).to receive(:description).and_return("cool hangout spot")
      allow(excursion).to receive(:location).and_return("Harding Drive, New Orleans, LA, USA")
      allow(excursion).to receive(:id).and_return(1)
      allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])

      visit excursions_new_path
      fill_in :title, with: excursion.title
      fill_in :description, with: excursion.description
      fill_in :location, with: excursion.location
      click_button('Create Excursion')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You have successfully created an Excursion!")
      within('#my_excursions') do
        expect(page).to have_content(excursion.title)
      end
    end
  end

  describe 'page contents' do
    it 'starts with no map and fields are not pre-filled' do
      user = User.create!(name: 'Yesi', email: 'yesi@example.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit excursions_new_path

      expect(page).to have_field(:place, placeholder: 'Search...')
      expect(page.find_field(:title).value).to be nil
      expect(page.find_field(:location).value).to be nil
      expect(page.find_field(:description).value).to be_empty
      expect(page).not_to have_css('#map')
    end
  end
end
