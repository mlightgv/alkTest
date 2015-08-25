require 'csv'

class Parser

  attr_reader :file_in

  def initialize(args)
    @file = args[:file_in]
  end

  def parser_data
    results = Array.new
    CSV.foreach(@file, headers: true, skip_blanks: true) do |row|
        stats = Stats.new(  row['Campaign ID'],
                            row['Day'],
                            row["Impressions"].to_i,
                            row["Clicks"].to_i, 
                            row["Cost"].to_i, 
                            row["Converted clicks"].to_i, 
                            row["Cost / converted click"].to_i, 
                            row["Click conversion rate"].to_i, 
                            row["Final URL"] )
        results << stats
    end
    results
  end

  Stats = Struct.new( :id_campaign, 
                      :day, 
                      :impressions, 
                      :clicks, 
                      :cost, 
                      :converted_clicks,
                      :cost_div_converted_click, 
                      :converted_clicks_div_clicks, 
                      :final_url ) 
end
