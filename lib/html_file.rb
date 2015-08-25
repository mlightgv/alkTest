require 'markaby'

class Html

  attr_reader :reports, :output

  def initialize(args)   
    @reports = args[:reports]
    @output = args[:output]
  end

  def build_html_report
    html_format = build_html(@reports)
    output_html_report(html_format.to_s)
    html_format.to_s
  end

  private

  def build_html(reports)
    html_format = Markaby::Builder.new
    html_format.html5 do
      head { title "Alkhemy" }
      body do
        reports.each do |title, report|
          br
          h1 title
          table :border => "1" do
            report.each do |name, value|
              tr do
                td name
                value.each{ |v| td v }
              end
            end
          end
        end
      end
    end
    html_format
  end

  def output_html_report(content)
    begin
      @out_file = File.new(output, "w+")
      @out_file.puts(content)
      @out_file.close
    rescue Exception => e
      puts "Error: #{e}" 
    end 
  end

end