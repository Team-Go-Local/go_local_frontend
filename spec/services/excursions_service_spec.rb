require 'rails_helper'

RSpec.describe ExcursionsService do
  describe '.create_excursion' do
    it 'sends a request to the BE to create an excursion in the DB' do
      json_response = File.read('spec/fixtures/excursion_response.json')
      stub_request(:post, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/123/excursions/create?description=Sample%20description&location=Denver,%20CO&title=Casa%20Bonita&user_id=123")
      . with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v1.3.0'
        })
      .to_return(status: 200, body: json_response)

      excursion = ExcursionsService.create_excursion({title: 'Casa Bonita', description: 'Sample description', location: 'Denver, CO', user_id: 123})

      expect(excursion).to be_an Hash
      expect(excursion[:data][:attributes][:name]).to be_a String
      expect(excursion[:data][:attributes][:formatted_address]).to be_a String
      expect(excursion[:data][:attributes][:types]).to be_an Array
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
