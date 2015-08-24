class Statistic

attr_reader :results

  def initialize(args)
    @results = args[:results]
  end

  def highest_impressions 
    @results.select { |a| a[:id_campaing].strip != "--" }.max_by(&:impressions)
  end

  def highest_clicks  
    @results.select { |a| a[:id_campaing].strip != "--" }.max_by(&:clicks)
  end 

  def highest_converted_clicks 
    @results.select { |a| a[:id_campaing].strip != "--" }.max_by(&:converted_clicks)
  end 

  def lowest_cost 
    @results.select { |a| a[:id_campaing].strip != "--" }.min_by(&:cost)
  end

  def highest_converted_clicks_div_clicks 
    @results.select { |a| a[:id_campaing].strip != "--" }.max_by(&:converted_clicks_div_clicks)
  end  

  def lowest_cost_div_converted_click 
    @results.select { |a| a[:id_campaing].strip != "--" }.min_by(&:cost_div_converted_click)
  end

end