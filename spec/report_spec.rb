require 'statistic'
require 'parse_csv'
require 'report'
require 'yaml'

describe Report do

  before do
    @yaml = YAML.load_file("./fixtures/report.yml")
    parse = ParseCSV.new(:file_in => "spec/ad_performance_aug.csv")
    statistics = Statistic.new(:results => parse.parse_data)
    columns = { @yaml["column_name2"] => "id_campaing", @yaml["column_name3"] => "final_url", @yaml["column_name4"] => "day" }
    metrics = { @yaml["row_metric_name1"] => statistics.highest_impressions,
                @yaml["row_metric_name2"] => statistics.highest_clicks,
                @yaml["row_metric_name3"] => statistics.highest_converted_clicks, 
                @yaml["row_metric_name4"] => statistics.lowest_cost,
                @yaml["row_metric_name5"] => statistics.highest_converted_clicks_div_clicks, 
                @yaml["row_metric_name6"] => statistics.lowest_cost_div_converted_click }
    report = Report.new(:metrics => metrics, :columns => columns)
    @report = report.generate_report
  end

  it "Show Title" do
    expect(@report[@yaml["column_name1"]]).to eql(@yaml["headers"])
  end

  it "Show Highest Impressions" do
    expect(@report[@yaml["row_metric_name1"]]).to eql(@yaml["row_value1"])
  end

  it "Show Highest Clicks" do
    expect(@report[@yaml["row_metric_name2"]]).to eql(@yaml["row_value2"])
  end

  it "Show Highest Converted Clicks" do
    expect(@report[@yaml["row_metric_name3"]]).to eql(@yaml["row_value3"])
  end

  it "Show Lowest Cost" do
    expect(@report[@yaml["row_metric_name4"]]).to eql(@yaml["row_value4"])
  end

  it "Show Highest Conv. Clicks/Clicks" do
    expect(@report[@yaml["row_metric_name5"]]).to eql(@yaml["row_value5"])
  end

  it "Show Lowest Cost / Converted Click" do
    expect(@report[@yaml["row_metric_name6"]]).to eql(@yaml["row_value6"])
  end

end