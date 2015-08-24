require 'statistic'
require 'parse_csv'
require 'report'
require 'html_file'

describe Html do

  before do
    # Get data
    parse = ParseCSV.new(:file_in => "spec/ad_performance_aug.csv")
    data = parse.parse_data
    # Get statistics for report 1
    statistics = Statistic.new(:results => data)
    metric = { :row1 => "Highest Impressions", :row2 => "Highest Clicks", :row3 => "Highest Converted Clicks", :row4 => "Lowest Cost", :row5 => "Highest Conv. Clicks/Clicks", :row6 => "Lowest Cost / Converted Click"}
    metrics = Hash.new
    metrics = { metric[:row1] => statistics.highest_impressions,
                metric[:row2] => statistics.highest_clicks,
                metric[:row3] => statistics.highest_converted_clicks, 
                metric[:row4] => statistics.lowest_cost,
                metric[:row5] => statistics.highest_converted_clicks_div_clicks, 
                metric[:row6] => statistics.lowest_cost_div_converted_click }
    columns = { "Campaign ID" => "id_campaing", "Final URL" => "final_url", "Day" => "day" }
    # Generate Report
    report = Report.new(:metrics => metrics, :columns => columns)
    data_report = report.generate_report
    # Include it in hash of reports
    reports = Hash.new
    reports = {"Google Ad Performance Report" => data_report}
    # Convert Report to HTML format
    @html = Html.new(:reports => reports, :output => "report.html")
  end

  it "Convert report to HTML format" do
    output_expect = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"/><title>Report</title></head><body><br/><h1>Google Ad Performance Report</h1><table border=\"1\"><tr><td>Metrics</td><td>Campaign ID</td><td>Final URL</td><td>Day</td></tr><tr><td>Highest Impressions</td><td>243061000</td><td>http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/</td><td>9/08/2015</td></tr><tr><td>Highest Clicks</td><td>243061000</td><td>http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/</td><td>6/08/2015</td></tr><tr><td>Highest Converted Clicks</td><td>243061000</td><td>http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/</td><td>6/08/2015</td></tr><tr><td>Lowest Cost</td><td>243061000</td><td>http://courses.alkhemyinstitute.edu.au/bachelor-of-holistic-counselling/</td><td>12/08/2015</td></tr><tr><td>Highest Conv. Clicks/Clicks</td><td>243061000</td><td>http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/</td><td>3/08/2015</td></tr><tr><td>Lowest Cost / Converted Click</td><td>243061000</td><td>http://courses.alkhemyinstitute.edu.au/advanced-diploma-of-transpersonal-art-therapy/</td><td>2/08/2015</td></tr></table></body></html>"
    output_obtained = @html.build_html_report
    expect(output_obtained).to eql(output_expect)
  end

end