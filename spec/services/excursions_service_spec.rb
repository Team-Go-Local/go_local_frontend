require 'rails_helper'

RSpec.describe ExcursionsService do
  describe '.create_excursion' do
    it 'sends a request to the BE to create an excursion in the DB' do
      json_response = File.read('spec/fixtures/excursion_response.json')
      stub_request(:get, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/123/excursions/create?description=Sample%20description&location=Denver,%20CO&title=Casa%20Bonita&user_id=123")
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
    describe "list all excursions" do 
      it "can send a request to list all excursions" do 
        json_response = File.read('spec/fixtures/all_excursions.json')
        stub_request(:get, "https://tranquil-refuge-53915.herokuapp.com/api/v1/excursions").to_return(status: 200, body: json_response)
  

        json_data = ExcursionsService.list_all_excursions

        expect(json_data).to have_key(:data)
        expect(json_data[:data]).to be_an(Array)
        expect(json_data[:data].first[:id]).to be_an(Numeric)
        expect(json_data[:data].first[:type]).to be_a(String)
        expect(json_data[:data].first[:attributes]).to be_a(Hash)
        expect(json_data[:data].first[:attributes][:title]).to be_a(String)
        expect(json_data[:data].first[:attributes][:description]).to be_a(String)
      end
    end
  end
end