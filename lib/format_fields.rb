require 'money'

module FormatFields
	module_function

  def format_currency(money, unit)
    "#{Money.new(100, unit).currency.symbol}#{money.to_i/1000000.0}"
  end

  def format_percentage(value, places)
    "#{"%.#{places}f" % value.to_f}%"
  end

end