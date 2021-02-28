require 'rails_helper'

describe 'Excursion Edit' do
  describe 'happy path' do
    it 'can edit an excursion and be redirected to dashboard' do
      visit root_path
      stub_omniauth
      within('.login') { click_link }
      #create the excursion (mock call to BE, should respond with JSON)
      #within the excursion block
      click_button "Edit" #calls BE with the id to edit (stub once we have facade and service)

      fill_in :title, with: "Sample Title"
      fill_in :description, with: "Sample Description"
      fill_in :location, with: "Denver, CO"

      click_button "Update Excursion"

      expect(current_path).to eq(dashboard_path)
      within('#local') do
        expect(page).to have_content("Denver, CO")
      end
    end
  end
end
