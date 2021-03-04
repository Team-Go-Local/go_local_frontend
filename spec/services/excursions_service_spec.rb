require 'rails_helper'

RSpec.describe ExcursionsService do
  describe '.create_excursion' do
    it 'sends a request to the BE to create an excursion in the DB' do
      user = create(:user)
      stub_request(:post, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}/excursions").to_return(status: 201)

      excursion_params = {
        place_id: "ChIJE8tYRySHa4cRSaud_fDROfk",
        location: "2440 18th St NW, Washington, DC, 20009, United States",
        title: "Millie & Al's",
        description: "Great atmosphere with skeleton siren to announce specials.",
        user_id: user.id
      }
      response = ExcursionsService.create_excursion(excursion_params)

      expect(response).to eq(201)
    end
  end
  describe '.user_excursions' do
    it 'can send a request to the BE to see all of the specific users excursions' do
      user = create(:omniauth_mock_user)
      json_response = File.read('spec/fixtures/user_excursions.json')
      stub_request(:get, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}/excursions").to_return(status: 200, body: json_response)

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
  describe '.update_excursion' do
    it 'sends a request to the BE to update an excursion in the DB' do
      user = create(:user)
      excursion_params = {
        location: "2440 18th St NW, Washington, DC, 20009, United States",
        title: "Millie & Al's",
        description: "Great atmosphere with skeleton siren to announce specials."
      }

      stub_request(:patch, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}/excursions/7").to_return(status: 200)

      response = ExcursionsService.update_excursion(excursion_params, user.id, 7)

      expect(response).to eq(200)
    end
  end
  describe '.get_excursion' do
    it 'can send a request to the BE to see a specific excursion' do
      json_response = File.read('spec/fixtures/excursion.json')
      excursion_info = JSON.parse(json_response, symbolize_names: true)
      excursion_id = excursion_info[:data][:id]
      stub_request(:get, "https://go-local-be.herokuapp.com/api/v1/excursions/#{excursion_id}").to_return(status: 200, body: json_response)

      data = ExcursionsService.get_excursion(excursion_id)
      excursion = data[:data]
      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)
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
    end
  end
  describe '.destroy_excursion' do
    it 'can send a request to the BE to destroy a specific excursion' do
      user = create(:user)
      excursion_id = 7
      stub_request(:delete, "https://go-local-be.herokuapp.com/api/v1/users/#{user.id}/excursions/#{excursion_id}").to_return(status: 200)

      response = ExcursionsService.destroy_excursion(user.id, excursion_id)
      expect(response).to eq(200)
    end
    describe "list all excursions" do 
      it "can send a request to list all excursions" do 
        json_response = File.read('spec/fixtures/all_excursions.json')
        stub_request(:get, "https://go-local-be.herokuapp.com/api/v1/excursions").to_return(status: 200, body: json_response)
  

        json_data = ExcursionsService.list_all_excursions

        expect(json_data).to have_key(:data)
        expect(json_data[:data]).to be_an(Array)
        expect(json_data[:data].first[:id]).to be_an(String)
        expect(json_data[:data].first[:type]).to be_a(String)
        expect(json_data[:data].first[:attributes]).to be_a(Hash)
        expect(json_data[:data].first[:attributes][:title]).to be_a(String)
        expect(json_data[:data].first[:attributes][:description]).to be_a(String)
        
        expect(json_data[:meta]).to be_a(Hash)
        expect(json_data[:meta]).to have_key(:cities)
        expect(json_data[:meta][:cities]).to be_an(Array)
        expect(json_data[:meta][:cities][0]).to be_a(String)
      end
    end
  end
end
