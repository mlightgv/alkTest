require 'html_file'
require 'yaml'

describe Html do

  before do
    @yaml = YAML.load_file("./fixtures/html_file.yml")
    # 1) Include report in a list of reports
    reports = {@yaml["title"] => @yaml["report"]}
    # 2) Convert reports to HTML format and generate output file
    @html = Html.new(:reports => reports, :output => "report.html")
  end

  it "Convert report to HTML format" do
    output_expect = @yaml["html"]
    output_obtained = @html.build_html_report
    expect(output_obtained).to eql(output_expect)
  end

end