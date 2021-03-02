class ExcursionsService
  class << self
    def create_excursion(params)
      conn.post("api/v1/users/#{params[:user_id]}/excursions") do |request|
        request.body = {excursion: params}.to_json
      end.status
    end

    def get_excursion(id)

    end

    def update_excursion(params, id)
      conn.patch("api/v1/users/#{params[:user_id]}/excursions/#{id}") do |request|
        request.body = {excursion: params}.to_json
      end.status
    end

    def user_excursions(user_id)
      response = conn.get("api/v1/users/#{user_id}/excursions")
      parse_data(response)
    end

    private

    def conn
      @conn ||= Faraday.new(url: "https://tranquil-refuge-53915.herokuapp.com/")
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
