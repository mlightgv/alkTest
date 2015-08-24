class Statistic

attr_reader :results

  def initialize(args)
    @results = args[:results]
  end

  def highest_impressions 
    select_data.max_by(&:impressions)
  end

  def highest_clicks  
    select_data.max_by(&:clicks)
  end 

  def highest_converted_clicks 
    select_data.max_by(&:converted_clicks)
  end 

  def lowest_cost 
    select_data.min_by(&:cost)
  end

  def highest_converted_clicks_div_clicks 
    select_data.max_by(&:converted_clicks_div_clicks)
  end  

  def lowest_cost_div_converted_click 
    select_data.min_by(&:cost_div_converted_click)
  end

  private

  def select_data
    @results.select { |a| a[:id_campaing].strip != "--" }
  end

end