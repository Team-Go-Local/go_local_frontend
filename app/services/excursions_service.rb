class ExcursionsService
  class << self
    def create_excursion(params)
      conn.post("api/v1/users/#{params[:user_id]}/excursions") do |request|
        request.body = {excursion: params}.to_json
      end.status
    end

    def get_excursion(id)
      response = conn.get("api/v1/excursions/#{id}")
      parse_data(response)
    end

    def list_all_excursions
      response = conn.get("/api/v1/excursions")
      parse_data(response)
    end

    def update_excursion(excursion_params, user_id, excursion_id)
      conn.patch("api/v1/users/#{user_id}/excursions/#{excursion_id}") do |request|
        request.body = {excursion: excursion_params}.to_json
      end.status
    end

    def user_excursions(user_id)
      response = conn.get("api/v1/users/#{user_id}/excursions")
      parse_data(response)
    end

    def destroy_excursion(user_id, excursion_id)
      conn.delete("api/v1/users/#{user_id}/excursions/#{excursion_id}").status
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
