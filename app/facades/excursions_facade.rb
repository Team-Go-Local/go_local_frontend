class ExcursionsFacade
  class << self
    def create_excursion(params)
      status = ExcursionsService.create_excursion(params)
      messages(status, 'create')
    end

    def update_excursion(excursion_params, user_id, excursion_id)
      status = ExcursionsService.update_excursion(excursion_params, user_id, excursion_id)
      messages(status, 'update')
    end

    def destroy_excursion(user_id, excursion_id)
      status = ExcursionsService.destroy_excursion(user_id, excursion_id)
      messages(status, 'delete')
    end

    def messages(status, action)
      if [200, 201].include?(status)
        "You have successfully #{action}d an Excursion!"
      else
        "We're sorry, we were unable to #{action} your excursion. Please try again later."
      end
    end

    def get_excursion(id)
      data = ExcursionsService.get_excursion(id)
      ExcursionDetails.new(data[:data])
    end

    def edit_excursion(id)
      data = ExcursionsService.get_excursion(id)
      Excursion.new(data[:data])
    end

    def list_all_excursions(city = nil)
      data = ExcursionsService.list_all_excursions(city)
      data[:data].map do |excursion|
        Excursion.new(excursion)
      end
    end

    def city_list
      data = ExcursionsService.list_all_excursions
      data[:meta][:cities].reject(&:nil?)
    end

    def favorite_excursion(user_id, excursion_id)
      ExcursionsService.favorite_excursion(user_id, excursion_id)
    end
  end
end
