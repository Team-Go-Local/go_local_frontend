class ExcursionsService
  class << self
    def create_excursion(params_2)
      response = conn.post("api/v1/users/#{params_2[:user_id]}/excursions/create?#{params_2.to_query}")
      # parse_data(response)
    end

    def update_excursion(params_2)
      response = conn.patch("api/v1/users/#{params_2[:user_id]}/excursions/edit?#{params_2.to_query}")
      parse_data(response)
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
