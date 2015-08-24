require 'money'

module FormatFields

  def self.format_currency(money, unit)
    symbol = Money.new(100, unit).currency.symbol
    currency  = "#{symbol}#{money.to_i/1000000.0}"
  end

  def self.format_percentage(value, places)
    percentage = "%.#{places}f" % value.to_f
    percentage = "#{percentage}%"
  end

end