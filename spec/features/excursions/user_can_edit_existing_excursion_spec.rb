require 'rails_helper'

describe 'Excursion Edit' do
  describe 'happy path' do
    it 'can edit an excursion and be redirected to dashboard' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(ExcursionsService).to receive(:update_excursion).and_return(200)

      excursion = Excursion.new({ id: 5,
                                  attributes: {
                                  title: 'Cabrini Bridge',
                                  description: 'cool hangout spot',
                                  location: 'Harding Drive, New Orleans, LA, USA'
                                  }})

      allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])
      allow(ExcursionsFacade).to receive(:edit_excursion).and_return(excursion)
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])                           
      visit dashboard_path
      within('#my_excursions') do
        click_link('Edit')
      end

      expect(current_path).to eq(excursions_edit_path(excursion.id))

      expect(find_field(:title).value).to eq(excursion.title)
      expect(find_field(:description).value).to eq(excursion.description)
      expect(find_field(:location).value).to eq(excursion.location)


      fill_in :title, with: 'Magnolia Bridge'
      fill_in :description, with: 'Lots of fun'
      click_button('Update Excursion')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You have successfully updated an Excursion!")
      within('#my_excursions') do
        expect(page).to have_content(excursion.title)
      end
    end
  end

  describe 'sad path' do
    it 'validates that all fields have been filled out' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      excursion = Excursion.new({ id: 5,
                                  attributes: {
                                  title: 'Cabrini Bridge',
                                  description: 'cool hangout spot',
                                  location: 'Harding Drive, New Orleans, LA, USA'
                                  }})
      allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])
      allow(ExcursionsFacade).to receive(:edit_excursion).and_return(excursion)
      allow(ExcursionsFacade).to receive(:update_excursion)

      visit excursions_edit_path(excursion.id)

      fill_in :title, with: ""
      click_button('Update Excursion')

      expect(page).to have_content('Title can\'t be blank')
      expect(page.find_field(:description).value).to eq(excursion.description)
      expect(page.find_field(:location).value).to eq(excursion.location)
    end

    it 'displays an error message if the backend call is unsucessful' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      excursion = Excursion.new({ id: 5,
                                  attributes: {
                                  title: 'Cabrini Bridge',
                                  description: 'cool hangout spot',
                                  location: 'Harding Drive, New Orleans, LA, USA'
                                  }})
      allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])
      allow(ExcursionsFacade).to receive(:edit_excursion).and_return(excursion)
      allow(DashboardFacade).to receive(:favorited_excursions).and_return([])

      stub_request(:patch, "https://go-local-be.herokuapp.com/api/v1/users/1/excursions/#{excursion.id}").to_return(status: 500)
      visit excursions_edit_path(excursion.id)

      fill_in :title, with: "Magnolia Bridge"
      click_button('Update Excursion')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("We're sorry, we were unable to update your excursion. Please try again later.")
    end
  end
end
