require 'rails_helper'

describe 'Excursion Edit' do
  describe 'happy path' do
    it 'can edit an excursion and be redirected to dashboard' do
      visit root_path
      stub_omniauth
      click_link 'Login with Google'

      click_button "Edit"

      fill_in :title, with: "Sample Title"
      fill_in :description, with: "Sample Description"
      fill_in :location, with: "Denver, CO"

      click_button "Edit Excursion"

      expect(current_path).to eq(dashboard_path)
      within('#local') do
        expect(page).to have_content("Denver, CO")
      end
    end
  end
end
