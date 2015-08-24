require_relative 'parse_csv'
require_relative 'report'
require_relative 'statistic'
require_relative 'html_file'

class Main

  attr_reader :input, :output

  def initialize(args)
    @input = args[:input]
    @output = args[:output]
  end

  def generate_report
    statistics = get_statistics(get_data)
    metrics = Hash.new
    metrics = { "Highest Impressions" => statistics.highest_impressions,
                "Highest Clicks" => statistics.highest_clicks,
                "Highest Converted Clicks" => statistics.highest_converted_clicks, 
                "Lowest Cost" => statistics.lowest_cost,
                "Highest Conv. Clicks/Clicks" => statistics.highest_converted_clicks_div_clicks, 
                "Lowest Cost / Converted Click" => statistics.lowest_cost_div_converted_click }
    columns = { "Campaign ID" => "id_campaing", "Final URL" => "final_url", "Day" => "day" }
    report = get_report(metrics, columns)
    get_output("Google Ad Performance Report", report)
  end

  private

  def get_data
    parse = ParseCSV.new(:file_in => @input)
    data = parse.parse_data
  end

  def get_statistics(data)
    statistics = Statistic.new(:results => data)
  end

  def get_report(metrics, columns)
    report = Report.new(:metrics => metrics, :columns => columns)
    data_report = report.generate_report
  end

  def get_output(title, data_report)
    html = Html.new(:title => title, :info => data_report, :output => @output)
    output = html.build_html
  end

end

main = Main.new(:input => "ad_performance_aug.csv", :output => "report.html")
main.generate_report