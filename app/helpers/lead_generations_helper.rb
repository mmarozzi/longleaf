module LeadGenerationsHelper
  def options_for_months
    numbers = (1..12).to_a.map { |num| [ num, num ] }
    options_for_select(numbers)
  end
end
