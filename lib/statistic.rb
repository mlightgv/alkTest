class Statistic

attr_reader :results

  def initialize(args)
    @results = args[:results]
  end

  def highest_impressions 
    basic_filter.max_by(&:impressions)
  end

  def highest_clicks  
    basic_filter.max_by(&:clicks)
  end 

  def highest_converted_clicks 
    basic_filter.max_by(&:converted_clicks)
  end 

  def lowest_cost 
    cost_filter.min_by(&:cost)
  end

  def highest_converted_clicks_div_clicks 
    basic_filter.max_by(&:converted_clicks_div_clicks)
  end  

  def lowest_cost_div_converted_click 
    cost_div_converted_click_filter.min_by(&:cost_div_converted_click)
  end

  private

  def filter
    @results.select { |a| a[:id_campaign].strip != "--" }
  end

  def basic_filter
    filter.select { |a| Date.strptime(a[:day], "%Y-%m-%d").strftime("%m") == "08" }
  end

  def cost_filter
    basic_filter.select { |a| a[:cost] > 0 }
  end

  def cost_div_converted_click_filter
    basic_filter.select { |a| a[:cost_div_converted_click] > 0 }
  end

end