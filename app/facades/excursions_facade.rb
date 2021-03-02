class ExcursionsFacade
  class << self
    def create_excursion(params)
      ExcursionsService.create_excursion(params)
    end

    def updated_excursions(params)
      data = ExcursionsService.update_excursions(params)
      # excursions = ExcrusionsDetails.patch(data[:data][:attributes])
    end
  end
end
