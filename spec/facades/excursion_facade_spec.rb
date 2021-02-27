require 'rails_helper'

RSpec.describe ExcursionsFacade do
  describe '.create_excursion' do
    it 'creates an excursion and request to the backend to store the data on the DB' do
      json_response = File.read('spec/fixtures/excursion_response.json')
      stub_request(:get, "https://tranquil-refuge-53915.herokuapp.com/api/v1/users/123/excursions/create?description=Sample%20description&location=Denver,%20CO&title=Casa%20Bonita&user_id=123")
      . with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v1.3.0'
        })  
      .to_return(status: 200, body: json_response)
  
      excursion = ExcursionsFacade.create_excursion({title: 'Casa Bonita', description: 'Sample description', location: 'Denver, CO', user_id: 123})

      expect(excursion).to be_an Hash
      expect(excursion[:data][:attributes][:name]).to be_a String
      expect(excursion[:data][:attributes][:formatted_address]).to be_a String
      expect(excursion[:data][:attributes][:types]).to be_an Array
    end
  end
end