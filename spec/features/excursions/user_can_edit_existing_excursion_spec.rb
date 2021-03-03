require 'rails_helper'

describe 'Excursion Edit' do
  describe 'happy path' do
    it 'can edit an excursion and be redirected to dashboard' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(ExcursionsFacade).to receive(:update_excursion)

      excursion = Excursion.new({ id: 5,
                                  attributes: {
                                  title: 'Cabrini Bridge',
                                  description: 'cool hangout spot',
                                  location: 'Harding Drive, New Orleans, LA, USA'
                                  }})

      allow(DashboardFacade).to receive(:user_excursions).and_return([excursion])
      allow(ExcursionsFacade).to receive(:get_excursion).and_return(excursion)

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
      expect(page).to have_content("You have successfully edited an Excursion!")
      within('#my_excursions') do
        expect(page).to have_content(excursion.title)
      end
    end
  end
end
