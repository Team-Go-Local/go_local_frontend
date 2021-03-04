class DashboardFacade
  def self.user_excursions(user_id)
    data = ExcursionsService.user_excursions(user_id)
    data[:data].map do |excursion|
      Excursion.new(excursion)
    end
  end

  def self.favorited_excursions(user_id)
    data = ExcursionsService.favorited_excursions(user_id)
    data[:data].map do |excursion|
      Excursion.new(excursion)
    end
  end
end
