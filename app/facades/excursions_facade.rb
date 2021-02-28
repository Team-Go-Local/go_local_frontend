class ExcursionsFacade 
  class << self
    def create_excursion(params_2)
      ExcursionsService.create_excursion(params_2)
    end
  end
end