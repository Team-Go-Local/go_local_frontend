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
        expect(page).to have_css('.excursion-location')
        expect('.excursion-title').to_not be_empty 
        expect('.excursion-description').to_not be_empty 
        expect('.excursion-location').to_not be_empty 
      end 
    end 
  end 
end