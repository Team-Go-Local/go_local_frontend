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
  describe '.destroy_excursion' do
    it 'sends a delete request to the the excursion service' do
      user = create(:user)
      excursion_id = 7
      allow(ExcursionsService).to receive(:destroy_excursion).and_return(200)
      response = ExcursionsFacade.destroy_excursion(user.id, excursion_id)

      expect(response).to eq(200)
    end
    describe "list all excursions" do 
      it "can receive a list of all excursions" do 
        json_response = File.read('spec/fixtures/all_excursions.json')
        stub_request(:get, "https://go-local-be.herokuapp.com/api/v1/excursions").to_return(status: 200, body: json_response)
  
        json_data = ExcursionsFacade.list_all_excursions

        expect(json_data).to be_an(Array)
        expect(json_data.first).to be_an(Excursion)
        expect(json_data.count).to eq(3)
      end
    end
  end
end
