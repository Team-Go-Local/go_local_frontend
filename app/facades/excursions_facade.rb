class ExcursionsFacade
  class << self
    def create_excursion(params)
      ExcursionsService.create_excursion(params)
    end

    def get_excursion(id)
      data = ExcursionsService.get_excursion(id)
      Excursion.new(data[:data])
    end

    def update_excursion(params, id)
      ExcursionsService.update_excursion(params, id)
    end
  end
end
