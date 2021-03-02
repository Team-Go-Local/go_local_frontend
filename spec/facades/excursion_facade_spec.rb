require 'rails_helper'

RSpec.describe ExcursionsFacade do
  describe '.create_excursion' do
    it 'sends a post request to the excursion service' do
      allow(ExcursionsService).to receive(:create_excursion).and_return(204)

      user = create(:user)
      excursion_params = {
        place_id: "ChIJE8tYRySHa4cRSaud_fDROfk",
        location: "2440 18th St NW, Washington, DC, 20009, United States",
        title: "Millie & Al's",
        description: "Great atmosphere with skeleton siren to announce specials."
      }
      response = ExcursionsFacade.create_excursion(excursion_params, user.id)

      expect(response).to eq(204)
    end
  end
end
