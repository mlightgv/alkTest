require 'format_fields'

class Report

  attr_reader :metrics, :columns

  def initialize(args)
    @metrics = args[:metrics]
    @columns = args[:columns]
  end

  def generate_report
    build_table(get_titles, get_fields)
  end

  private

  def get_titles
    { "Metrics" => @columns.keys }
  end

  def get_fields
    @columns.values
  end

  def build_table(titles, fields)
    table = {}
    table = table.merge(titles)
    @metrics.each do |name, values|
      table = table.merge(add_row(name, filter_fields(fields, values)))
    end
    table
  end

  def filter_fields(fields, values)
    fields.map { |field| format_field(field, values[field.to_sym]) }
  end

  def format_field(field, value)
    v = case field
          when "cost"
            FormatFields.format_currency(value, "AUD")
          when "cost_div_converted_click"
            FormatFields.format_currency(value, "AUD")
          when "converted_clicks_div_clicks"
            FormatFields.format_percentage(value, 1)
          else
            value
        end
  end

  def add_row(name, row_values)
    { name => row_values }
  end
  
end