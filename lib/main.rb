require_relative 'parser'
require_relative 'summary'
require_relative 'statistic'
require_relative 'report'
require_relative 'html_file'

class Main

  attr_reader :input, :output

  def initialize(args)
    @input = args[0]
    @output = args[1]
  end

  def generate_report
    statistics = get_statistics(get_data)
    # 1) Build Data Report 
    metrics = { "Highest Impressions" => statistics.highest_impressions,
                "Highest Clicks" => statistics.highest_clicks,
                "Highest Converted Clicks" => statistics.highest_converted_clicks, 
                "Lowest Cost" => statistics.lowest_cost,
                "Highest Conv. Clicks/Clicks" => statistics.highest_converted_clicks_div_clicks, 
                "Lowest Cost / Converted Click" => statistics.lowest_cost_div_converted_click }
    columns = { "Campaign ID" => "id_campaign", "Final URL" => "final_url", "Day" => "day" }
    # 2) Tabular report
    report = get_report(metrics, columns)
    # 3) Include report in a list of reports
    reports = {"Google Ad Performance Report" => report}
    # 4) Convert reports to HTML format and generate output file
    get_output(reports)
  end

  private

  def get_data
    get_summary(Parser.new(:file_in => @input).parser_data)
  end

  def get_summary(data)
    Summary.new(:data => data).group_data
  end

  def get_statistics(data)
    Statistic.new(:results => data)
  end

  def get_report(metrics, columns)
    Report.new(:metrics => metrics, :columns => columns).generate_report
  end

  def get_output(reports)
    Html.new(:reports => reports, :output => @output).build_html_report
  end

end