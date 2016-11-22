module ApplicationHelper
  def to_euro(number)
    number.round.to_s + '€'
  end
end
