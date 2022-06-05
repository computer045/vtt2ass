# frozen_string_literal: true

require_relative 'vtt_file'
require_relative 'ass_file'

##
# Main application class that manages all the operations.
class Application
  ##
  # Creates a new Application instance.
  # It receives +options+ that can define the input and output directories.
  def initialize(input, options)
    @options = options
    @input = sanitize_path(input)
  end

  ##
  # Replace backslashes from Windows paths to normal slashes.
  # Deletes the trailing slash if there is one.
  def sanitize_path(path)
    path&.gsub('\\', '/')&.delete_suffix('/')
  end

  ##
  # This method starts the application process.
  # It sends the file_paths of VTT files in the input directory to convertFileToASS method
  # and outputs the resulting ASS format to a new file.
  def start
    if File.directory?(@input)
      Dir["#{@input}/*.vtt"].each do |file_path|
        convert(file_path)
      end
    elsif File.file?(@input)
      convert(@input)
    else
      raise StandardError.new('ERROR: Input file or directory does not exist.')
    end
  rescue SystemExit, Interrupt
    puts 'ERROR: The application stopped unexpectedly. The conversion may not have been completed.'
  rescue => error
    puts error.message
  end

  ##
  # This method launches the conversion process on the specified input file.
  def convert(input_path)
    output = sanitize_path(@options[:output])
    if File.directory?(output)
      ass_file = vtt_to_ass(input_path)
      ass_file.write_to_file("#{output}/#{File.basename(input_path).gsub('.vtt', '.ass')}") unless output.nil?
      puts ass_file.to_s unless @options[:quiet]
    else
      raise StandardError.new('ERROR: Output directory does not exist.')
    end
  end

  ##
  # This method creates a new VTTFile object from the file path provided and convert its content
  # inside a new ASSFile object.
  def vtt_to_ass(file_path)
    base_file_name = File.basename(file_path).gsub('.vtt', '')
    css_file =
      if !@options[:css].nil? && File.directory?(@options[:css])
        "#{sanitize_path(@options[:css])}/#{base_file_name}.css"
      elsif File.file?("#{file_path.gsub('.vtt', '')}.css")
        "#{file_path.gsub('.vtt', '')}.css"
      else
        @options[:css]
      end
    vtt_file = VTTFile.new(file_path, @options[:width], @options[:height])
    ass_file = ASSFile.new(
      (@options[:title].nil? ? base_file_name : @options[:title]),
      @options[:width],
      @options[:height],
      css_file
    )
    ass_file.convert_vtt_to_ass(vtt_file, @options[:font_family], @options[:font_size], @options[:line_offset])
    ass_file
  end
end
