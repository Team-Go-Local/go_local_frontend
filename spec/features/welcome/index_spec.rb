require 'rails_helper'

describe 'welcome page' do
  describe 'happy path' do
    it 'has a welcome message and login link' do
      stub_omniauth
      allow(DashboardFacade).to receive(:user_excursions).and_return([])

      visit root_path
      stub_omniauth

      expect(page).to have_content("Go Local")
      user = create(:omniauth_mock_user)
      stub_request(:post, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/#{user.id}")

      within('.login') { click_link }
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, John Smith")
    end
  end
end
