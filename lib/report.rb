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
    fields.each { |field| row << value[field.to_sym] }
    row
  end

  def add_row(name, row_values)
    new_row = { name => row_values }
  end
  
end