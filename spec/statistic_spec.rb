require 'statistic'
require 'parse_csv'


describe Statistic do

  before do
    parse = ParseCSV.new(:file_in => "spec/ad_performance_aug.csv")
    data = parse.parse_data
    @statistics = Statistic.new(:campaings => data)
  end

  it "Highest Impressions" do
    highest_value = @statistics.highest_impressions
    expect(highest_value[:impressions]).to eql(233)
  end

  it "Highest Clicks" do
    highest_value = @statistics.highest_clicks
    expect(highest_value[:clicks]).to eql(7)
  end

  it "Highest Converted Clicks " do
    highest_value = @statistics.highest_converted_clicks
    expect(highest_value[:converted_clicks]).to eql(1)
  end

  it "Lowest Cost " do
    lowest_value = @statistics.lowest_cost
    expect(lowest_value[:cost]).to eql("$0.0")
  end

  it "Highest Conv. Clicks/Clicks" do
    highest_value = @statistics.highest_converted_clicks_div_clicks
    expect(highest_value[:converted_clicks_div_clicks]).to eql("25.0%")
  end

  it "Lowest Cost / Converted Click" do
    lowest_value = @statistics.lowest_cost_div_converted_click
    expect(lowest_value[:cost_div_converted_click]).to eql(0)
  end

end