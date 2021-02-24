require 'rails_helper'

describe 'welcome page' do
  describe 'happy path' do
    it 'has a welcome message, login link, and register link' do
      visit root_path

      expect(page).to have_content("Welcome to Go Local!")
      expect(page).to have_link('Login with Google')
    end
  end
end
