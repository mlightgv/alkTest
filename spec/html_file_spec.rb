require 'html_file'
require 'yaml'

describe Html do

  before do
    @yaml = YAML.load_file("./fixtures/html_file.yml")
    # 1) Include report in a list of reports
    reports = {@yaml["title"] => @yaml["report"]}
    # 2) Convert reports to HTML format and generate output file
    @output_file = "report.html"
    Html.new(:reports => reports, :output => @output_file).build_html_report
  end

  it "Convert report to HTML format" do
    expect(File.file? @output_file).to eql(true)
  end

end