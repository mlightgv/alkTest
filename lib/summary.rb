class Summary

attr_reader :data

  def initialize(args)
    @data = args[:data]
  end

  def group_data
    results = Array.new
    campaigns = find_by
    campaigns.each do |x|
      rows = filter_data( x[0], x[1], x[2] )
      data = Stats.new( x[0], 
                        x[1], 
                        x[2], 
                        sum_values(rows, :impressions), 
                        sum_values(rows, :clicks),  
                        sum_values(rows, :converted_clicks),
                        sum_values(rows, :cost), 
                        sum_values(rows, :converted_clicks_div_clicks), 
                        sum_values(rows, :cost_div_converted_click) )
      results << data
    end
   results
  end

  private

  def find_by
    @data.map{ |a| [a[:id_campaign], a[:day], a[:final_url]] }.uniq
  end

  def filter_data(id_campaing, day, final_url)
    rows = @data.find_all{ |a| a[:id_campaign] == id_campaing && a[:day] == day && a[:final_url] == final_url }
  end

  def sum_values(rows, column_name)
    rows.inject(0){ |sum,t| sum + t[column_name.to_sym].to_i }
  end

  Stats = Struct.new( :id_campaign,
                      :day, 
                      :final_url,
                      :impressions,
                      :clicks,
                      :converted_clicks,
                      :cost, 
                      :converted_clicks_div_clicks, 
                      :cost_div_converted_click ) 

end