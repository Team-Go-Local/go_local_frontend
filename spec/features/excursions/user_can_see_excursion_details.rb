require 'rails_helper'

describe 'Excursion Show' do
  describe 'happy path' do
    it 'can see the excursion show page "excursions/:id' do
      VCR.use_cassette("excursion_details") do 
        excursion_id = "1"

        stub_omniauth
        user = create(:omniauth_mock_user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
        visit root_path
        within('.login') { click_link }

        visit excursions_show_path(excursion_id)
  
        expect(current_path).to eq(excursions_show_path(excursion_id))
        expect(page).to have_css('.excursion-title')
        expect(page).to have_css('.excursion-description')
        expect(page).to have_css('.excursion-updated_at')
        expect(page).to have_css('.excursion-address')
        expect(page).to have_css('.excursion-name')
        expect(page).to have_css('.excursion-types')
        expect(page).to have_css('.excursion-phone_number')
        expect(page).to have_css('.excursion-website')
        expect(page).to have_css('.excursion-business_status')
        expect(page).to have_css('.excursion-opening_hours')
        expect('.excursion-title').to_not be_empty 
        expect('.excursion-description').to_not be_empty 
        expect('.excursion-updated_at').to_not be_empty 
        expect('.excursion-address').to_not be_empty 
        expect('.excursion-name').to_not be_empty 
        expect('.excursion-types').to_not be_empty 
        expect('.excursion-phone_number').to_not be_empty 
        expect('.excursion-website').to_not be_empty 
        expect('.excursion-business_status').to_not be_empty 
        expect('.excursion-opening_hours').to_not be_empty 
      end 
    end 
  end 
end