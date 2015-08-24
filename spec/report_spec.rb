require 'statistic'
require 'parse_csv'
require 'report'

describe Report do

  before do
    parse = ParseCSV.new(:file_in => "spec/ad_performance_aug.csv")
    data = parse.parse_data
    statistics = Statistic.new(:results => data)
    columns = { "Campaign ID" => "id_campaing", "Final URL" => "final_url", "Day" => "day" }
    @metric = { :row1 => "Highest Impressions", :row2 => "Highest Clicks", :row3 => "Highest Converted Clicks", :row4 => "Lowest Cost", :row5 => "Highest Conv. Clicks/Clicks", :row6 => "Lowest Cost / Converted Click"}
    metrics = Hash.new
    metrics = { @metric[:row1] => statistics.highest_impressions,
                @metric[:row2] => statistics.highest_clicks,
                @metric[:row3] => statistics.highest_converted_clicks, 
                @metric[:row4] => statistics.lowest_cost,
                @metric[:row5] => statistics.highest_converted_clicks_div_clicks, 
                @metric[:row6] => statistics.lowest_cost_div_converted_click }
        report = Report.new(:metrics => metrics, :columns => columns)
    @report = report.generate_report
  end

  it "Show Title" do
    expect(@report["Metrics"]).to eql(["Campaign ID", "Final URL", "Day"])
  end

  it "Show Highest Impressions" do
    expect(@report[@metric[:row1]]).to eql(["243061000", "http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/", "9/08/2015"])
  end

  it "Show Highest Clicks" do
    expect(@report[@metric[:row2]]).to eql(["243061000", "http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/", "6/08/2015"])
  end

  it "Show Highest Converted Clicks" do
    expect(@report[@metric[:row3]]).to eql(["243061000", "http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/", "6/08/2015"])
  end

  it "Show Lowest Cost" do
    expect(@report[@metric[:row4]]).to eql(["243061000", "http://courses.alkhemyinstitute.edu.au/bachelor-of-holistic-counselling/", "12/08/2015"])
  end

  it "Show Highest Conv. Clicks/Clicks" do
    expect(@report[@metric[:row5]]).to eql(["243061000", "http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/", "3/08/2015"])
  end

  it "Show Lowest Cost / Converted Click" do
    expect(@report[@metric[:row6]]).to eql(["243061000", "http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/", "2/08/2015"])
  end

end