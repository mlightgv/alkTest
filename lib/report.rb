require 'format_fields'

class Report

  attr_reader :metrics, :columns

  def initialize(args)
    @metrics = args[:metrics]
    @columns = args[:columns]
  end

  def generate_report
    titles = get_titles
    fields = get_fields
    report = build_table(titles, fields)
  end

  private

  def get_titles
    titles = { "Metrics" => @columns.keys }
  end

  def get_fields
    fields = @columns.values
  end

  def build_table(titles, fields)
    table = Hash.new
    table = table.merge(titles)
    @metrics.map do |name, value|
      row = filter_fields(fields, value)
      table = table.merge(add_row(name, row))
    end
    table
  end

  def filter_fields(fields, value)
    row = Array.new
    fields.each do |field|
      v = format_field(field, value[field.to_sym])
      row << v
    end
    row
  end

  def format_field(field, value)
    case field
      when "cost"
        v = FormatFields.format_currency(value, "AUD")
      when "cost_div_converted_click"
        v = FormatFields.format_currency(value, "AUD")
      when "converted_clicks_div_clicks"
        v = FormatFields.format_percentage(value, 1)
      else
        v = value
    end
    v
  end

  def add_row(name, row_values)
    new_row = { name => row_values }
  end
  
end