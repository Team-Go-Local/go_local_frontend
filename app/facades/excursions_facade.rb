class ExcursionsFacade 
  class << self
    def create_excursion(params_2)
      ExcursionsService.create_excursion(params_2)
    end

    def list_all_excursions
      data = ExcursionsService.list_all_excursions
      data[:data].map do |excursion|
        Excursion.new(excursion)
      end
    end
  end
end