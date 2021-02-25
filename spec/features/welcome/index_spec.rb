require 'rails_helper'

describe 'welcome page' do
  describe 'happy path' do
    it 'has a welcome message, login link, and register link' do
      visit root_path

      expect(page).to have_content("Welcome to Go Local!")
      expect(page).to have_link('Login with Google')
      expect(current_path).to eq(root_path)
    end
  end
end
