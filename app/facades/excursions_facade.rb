class ExcursionsFacade
  class << self
    def create_excursion(params)
      ExcursionsService.create_excursion(params)
    end

    def get_excursion(id)
      data = ExcursionsService.get_excursion(id)
      Excursion.new(data[:data])
    end

    def update_excursion(excursion_params, user_id, excursion_id)
      ExcursionsService.update_excursion(excursion_params, user_id, excursion_id)
    end

    def destroy_excursion(user_id, excursion_id)
      ExcursionsService.destroy_excursion(user_id, excursion_id)
    end

    def list_all_excursions
      data = ExcursionsService.list_all_excursions
      data[:data].map do |excursion|
        Excursion.new(excursion)
      end
    end
  end
end
