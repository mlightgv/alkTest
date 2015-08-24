require 'markaby'
require 'fileutils'

class Html

  attr_reader :title, :info, :output

  def initialize(args)
    @title = args[:title]
    @info = args[:info]
    @output = args[:output]
  end

  def build_html 
    info = @info
    title = @title
    html_format = Markaby::Builder.new
    html_format.html5 do
      head { title "Report" }
      body do
        h1 title
        table :border => "1" do
          info.each do |key, value|
            tr do
              td key
                value.each{ |v| td v }
            end
          end
        end
      end
    end
    output_html_report(html_format.to_s)
    html_format.to_s
  end  

  def output_html_report(content)
    @out_file = File.new(output, "w+")
    @out_file.puts(content)
    @out_file.close
  end

end