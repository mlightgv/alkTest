class Statistic

attr_reader :results

  def initialize(args)
    @results = args[:results]
  end

  def highest_impressions 
    filter_data.max_by(&:impressions)
  end

  def highest_clicks  
    filter_data.max_by(&:clicks)
  end 

  def highest_converted_clicks 
    filter_data.max_by(&:converted_clicks)
  end 

  def lowest_cost 
    filter_data.min_by(&:cost)
  end

  def highest_converted_clicks_div_clicks 
    filter_data.max_by(&:converted_clicks_div_clicks)
  end  

  def lowest_cost_div_converted_click 
    filter_data.min_by(&:cost_div_converted_click)
  end

  private

  def filter_data
    @results.select { |a| a[:id_campaign].strip != "--" }
  end

end