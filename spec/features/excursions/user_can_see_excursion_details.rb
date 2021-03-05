require 'rails_helper'

describe 'Excursion Show' do
  describe 'happy path' do
    it 'can see the excursion show page "excursions/:id' do
      VCR.use_cassette("get_excursion") do 
        excursion_details = 
         {
          "id": "8",
          "type": "excursion_details",
          "attributes": {
              "id": 8,
              "title": "Museum of Contemporary Art Denver",
              "description": "fancy museum",
              "updated_at": "2021-03-04T21:16:33.100Z",
              "place_id": "ChIJvcHQQcF4bIcRmDttJRd0FN4",
              "nearest_city": nil,
              "formatted_address": "1485 Delgany St, Denver, CO 80202, USA",
              "name": "Museum of Contemporary Art Denver",
              "types": [
                  "tourist_attraction",
                  "museum",
                  "point_of_interest",
                  "establishment"
              ],
              "phone_number": "(303) 298-7554",
              "website": "http://www.mcadenver.org/",
              "business_status": "OPERATIONAL",
              "opening_hours": [
                  "Monday: Closed",
                  "Tuesday: 12:00 – 7:00 PM",
                  "Wednesday: 12:00 – 7:00 PM",
                  "Thursday: 12:00 – 7:00 PM",
                  "Friday: 12:00 – 7:00 PM",
                  "Saturday: 10:00 AM – 5:00 PM",
                  "Sunday: 10:00 AM – 5:00 PM"
              ]
          }
          }

        excursion = ExcursionDetails.new(excursion_details)
        stub_omniauth
        user = create(:omniauth_mock_user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow(DashboardFacade).to receive(:favorited_excursions).and_return([])
        
        visit excursions_show_path(excursion.id)
       
        expect(page).to have_css('.excursion-details')
        expect(page).to have_content(excursion.title)
        expect(page).to have_content(excursion.description)
        expect(page).to have_content(excursion.name)
      end 
    end 
  end 
end