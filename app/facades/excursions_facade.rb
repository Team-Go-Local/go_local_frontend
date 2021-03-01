class ExcursionsFacade 
  class << self
    def create_excursion(params_2)
      data = ExcursionsService.create_excursion(params_2)
      # excursions = ExcrusionsDetails.new(data[:data][:attributes])
    end

    def updated_excursions(params_2)
      data = ExcursionsService.update_excursions(params_2)
      # excursions = ExcrusionsDetails.patch(data[:data][:attributes])
    end
  end
end