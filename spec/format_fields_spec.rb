require 'format_fields'

describe FormatFields do

  it "Convert microcurrency into dollars and cents" do
    currency = FormatFields.format_currency(1230000, "USD")
    expect(currency).to eql("$1.23")
  end

  it "Display percentages up to one decimal place" do
    currency = FormatFields.format_percentage(45.67, 1)
    expect(currency).to eql("45.7%")
  end

end