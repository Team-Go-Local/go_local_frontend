require 'rails_helper'

describe DashboardFacade do
  it 'should return an array of excursion poros' do
    data = {data:
            [{"id": 5,
              "type": "excursion",
              "attributes": {
                  "place_id": "ChIJE7tYRySHa4cRSauU_fDROfk",
                  "location": "538 Hagan Avenue, New Orleans, LA, 70119, United States",
                  "title": "Parkway Bakery & Tavern",
                  "description": "Longtime (since 1911) neighborhood hangout with a patio known for classic-style po' boys."
                  }
                },
              {"id": 3,
                "type": "excursion",
                "attributes": {
                  "place_id": "ChIJE8tYRySHa4cRSaud_fDROfk",
                  "location": "2440 18th St NW, Washington, DC, 20009, United States",
                  "title": "Millie & Al's",
                  "description": "Great atmosphere with skeleton siren to announce specials."
                }
                }]}
    user = create(:omniauth_mock_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    allow(ExcursionsService).to receive(:user_excursions).and_return(data)

    excursions = DashboardFacade.user_excursions(user.id)

    expect(excursions).to be_an(Array)
    expect(excursions[0]).to be_an(Excursion)
  end
end
