require 'main'

class RunnerAlkhemy

  attr_reader :input, :output

  def initialize(arguments)
    if !arguments  
      show_error_message 
    elsif arguments.count != 2
      show_error_message 
    else
      @input = arguments[0]
      @output = arguments[1]
      validate_arguments
    end
  end

  def validate_arguments
    if (validate_input && validate_output)
      execute_main
    end
  end

  def validate_input
    begin
      validate_input_file
      validate_extention(File.extname(@input), ".csv")
      true
    rescue Exception => e
      puts "Error: #{e}" 
      false
    end 
  end

  def validate_output
    begin
      validate_extention(File.extname(@output), ".html")
      validate_output_directory(File.dirname(@output))
      true
    rescue Exception => e
      puts "Error: #{e}"
      false
    end 
  end


  def validate_input_file
    unless File.file? @input
      puts "ERROR: the directory does not exist or the input file does not exist or is not a file."
      exit
    end
  end

  def validate_output_directory(output)
    unless Dir.exists? output
      puts "ERROR: the directory #{output} does not exist."
      exit
    end
  end

  def validate_extention(output, extention)
    unless output == extention
      puts "ERROR: the extention of the file should be #{extention}."
      exit
    end
  end

  def show_error_message
    puts <<-eos
      Error: Wrong number of arguments. Enter the input and output parameters

      Example usage:
      
      ruby -I lib bin/alkhemy /Users/marygomez/ad_performance_aug.csv /Users/marygomez/report.html
      eos
    exit 
  end

  def execute_main
    main = Main.new(ARGV)
    main.generate_report
  end

end