require 'rails_helper'

RSpec.describe ExcursionsFacade do
  describe '.create_excursion' do
    it 'sends a post request to the excursion service' do
      allow(ExcursionsService).to receive(:create_excursion).and_return(201)

      user = create(:user)
      excursion_params = {
        place_id: "ChIJE8tYRySHa4cRSaud_fDROfk",
        location: "2440 18th St NW, Washington, DC, 20009, United States",
        title: "Millie & Al's",
        description: "Great atmosphere with skeleton siren to announce specials.",
        user_id: user.id
      }
      response = ExcursionsFacade.create_excursion(excursion_params)

      expect(response).to eq(201)
    end
  end
  describe '.get_excursion' do
    it 'gets excursion info from BE through service' do
      excursion_params =
      { data:
            { id: 7,
              type: "excursion",
              attributes:
                        { place_id: "ChIJE8tYRySHa4cRSaud_fDROfk",
                          location: "2440 18th St NW, Washington, DC, 20009, United States",
                          title: "Millie & Al's",
                          description: "Great atmosphere with skeleton siren to announce specials.",
                          user_id: 3
                          }}}
      allow(ExcursionsService).to receive(:get_excursion).and_return(excursion_params)

      excursion = ExcursionsFacade.get_excursion(7)
      expect(excursion).to be_an(Excursion)
    end
  end
  describe '.update_excursion' do
    it 'sends a patch request to the excursion service' do
      allow(ExcursionsService).to receive(:update_excursion).and_return(200)

      excursion_params = {
        location: "2440 18th St NW, Washington, DC, 20009, United States",
        title: "Millie & Al's",
        description: "Great atmosphere with skeleton siren to announce specials."
      }
      response = ExcursionsFacade.update_excursion(excursion_params, 2, 7)

      expect(response).to eq(200)
    end
  end
end
