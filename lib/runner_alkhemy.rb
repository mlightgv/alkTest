require 'main'

class RunnerAlkhemy

  def initialize(arguments)
    if !ARGV  
      show_error_message 
    elsif arguments.count < 2
      show_error_message 
    else
      validate_arguments(arguments)
    end
  end

  def validate_arguments(arguments)
    begin
      for i in 0..arguments.count - 1
        if (i == 0)
          validate_input_file(arguments[i])
          validate_output_extention(File.extname(arguments[i]), ".csv")
        else
          validate_output_extention(File.extname(arguments[i]), ".html")
          validate_output_directory(File.dirname(arguments[i]))
        end
      end
       execute_main
    rescue Exception => e
      puts "Error: #{e}" 
    end 
  end

  def validate_input_file(input)
    unless File.file? input
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

  def validate_output_extention(output, extention)
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