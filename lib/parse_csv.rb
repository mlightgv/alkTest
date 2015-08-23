require 'csv'

class ParseCSV

  attr_reader :file_in

  def initialize(args)
    @file = args[:file_in]
  end

  def parse_data
    results = Array.new
    CSV.foreach(@file, headers: true, skip_blanks: true) do |row|
        stats = Stats.new(  row['Campaign ID'],
                            row['Day'],
                            row["Impressions"],
                            row["Clicks"], 
                            row["Cost"], 
                            row["Converted clicks"], 
                            row["Cost / converted click"], 
                            row["Click conversion rate"], 
                            row["Final URL"] )
        results << stats
    end
    results
  end

  Stats = Struct.new( :id_campaing, 
                      :day, 
                      :impressions, 
                      :clicks, 
                      :cost, 
                      :converted_clicks,
                      :cost_div_converted_click, 
                      :converted_clicks_div_clicks, 
                      :final_url ) 

end
