require 'rails_helper'

describe 'Excursion Create' do
  describe 'happy path' do
    it 'can create an excursion and be redirected to dashboard' do
      visit root_path
      stub_omniauth
      click_link 'Login with Google'

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
end
