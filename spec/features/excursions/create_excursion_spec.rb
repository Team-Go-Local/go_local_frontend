require 'rails_helper'

describe 'Excursion Create' do
  describe 'happy path' do
    it 'can create an excursion and be redirected to dashboard' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(ExcursionsService).to receive(:create_excursion).and_return(201)

      excursion = instance_double("Excursion")
      allow(excursion).to receive(:title).and_return("Cabrini Bridge")
      allow(excursion).to receive(:description).and_return("cool hangout spot")
      allow(excursion).to receive(:location).and_return("Harding Drive, New Orleans, LA, USA")
      allow(excursion).to receive(:id).and_return(1)
      allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])

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
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
      
      visit excursions_new_path

      expect(page).to have_field(:place, placeholder: 'Search...')
      expect(page.find_field(:title).value).to be nil
      expect(page.find_field(:location).value).to be nil
      expect(page.find_field(:description).value).to be_empty
      expect(page).not_to have_css('#map')
    end
  end

  describe 'sad path' do
    it 'validates that all fields have been filled out' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
      visit excursions_new_path

      fill_in :title, with: "Cake Cafe"
      click_button('Create Excursion')

      expect(page).to have_content('Location can\'t be blank')
      expect(page).to have_content('Description can\'t be blank')
      expect(page.find_field(:title).value).to eq("Cake Cafe")
    end

    it 'displays an error message if the backend call is unsucessful' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      stub_request(:post, "https://go-local-be.herokuapp.com/api/v1/users/1/excursions").to_return(status: 500)
      allow(DashboardFacade).to receive(:user_excursions).and_return([])
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
      
      visit excursions_new_path
      fill_in :title, with: "Green Apple Books"
      fill_in :description, with: "Thousands of books"
      fill_in :location, with: "506 Clement St, San Francisco, CA 94118"
      click_button('Create Excursion')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("We're sorry, we were unable to create your excursion. Please try again later.")
    end
  end
end
