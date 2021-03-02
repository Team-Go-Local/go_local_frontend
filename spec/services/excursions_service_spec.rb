require 'rails_helper'

RSpec.describe ExcursionsService do
  describe '.create_excursion' do
    it 'sends a request to the BE to create an excursion in the DB' do
      user = create(:user)
      stub_request(:post, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/#{user.id}/excursions").to_return(status: 204)

      excursion_params = {
        place_id: "ChIJE8tYRySHa4cRSaud_fDROfk",
        location: "2440 18th St NW, Washington, DC, 20009, United States",
        title: "Millie & Al's",
        description: "Great atmosphere with skeleton siren to announce specials.",
        user_id: user.id
      }
      response = ExcursionsService.create_excursion(excursion_params)

      expect(response).to eq(204)
    end
  end

  describe '.user_excursions' do
    it 'can send a request to the BE to see all of the specific users excursions' do
      user = create(:omniauth_mock_user)
      json_response = File.read('spec/fixtures/user_excursions.json')
      stub_request(:get, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/#{user.id}/excursions").to_return(status: 200, body: json_response)

      data = ExcursionsService.user_excursions(user.id)
      excursion = data[:data][0]
      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)
      expect(data[:data]).to be_an(Array)
      expect(excursion).to be_a(Hash)
      expect(excursion).to have_key(:id)
      expect(excursion[:id]).to be_a(Numeric)
      expect(excursion).to have_key(:type)
      expect(excursion[:type]).to be_a(String)
      expect(excursion).to have_key(:attributes)
      expect(excursion[:attributes]).to be_a(Hash)
      expect(excursion[:attributes]).to have_key(:place_id)
      expect(excursion[:attributes][:place_id]).to be_a(String)
      expect(excursion[:attributes]).to have_key(:location)
      expect(excursion[:attributes][:location]).to be_a(String)
      expect(excursion[:attributes]).to have_key(:title)
      expect(excursion[:attributes][:title]).to be_a(String)
      expect(excursion[:attributes]).to have_key(:description)
      expect(excursion[:attributes][:description]).to be_a(String)
      expect(excursion[:attributes]).to have_key(:user_id)
      expect(excursion[:attributes][:user_id]).to be_a(Integer)
      expect(excursion.keys).to match_array(%i[id type attributes])
      expect(excursion[:attributes].keys).to match_array(%i[place_id location title description user_id])
      expect(data[:data].pluck(:attributes).pluck(:user_id).uniq.count).to eq(1)
    end
  end
end
