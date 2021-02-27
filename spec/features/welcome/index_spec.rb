require 'rails_helper'

describe 'welcome page' do
  describe 'happy path' do
    it 'has a welcome message, login link, and register link' do
      visit root_path

      expect(page).to have_content("Go Local")

      within('.login') { click_link }

      expect(current_path).to eq(dashboard_path)
      #expect(page).to have_content("Welcome, #{user.name}")
    end
  end
end
