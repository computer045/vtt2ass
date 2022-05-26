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
    @input = input ? input.gsub('\\', '/').delete_suffix('/') : '.'
    @output = options[:output] ? options[:output].gsub('\\', '/').delete_suffix('/') : nil
    @width = 1920
    @height = 1080
    @font_family = options[:font_family] || 'Open Sans Semibold'
    @font_size = options[:font_size] || 52
    @title = options[:title] if options[:title]
    @quiet = options[:quiet]
    @css = options[:css].gsub('\\', '/').delete_suffix('/') if options[:css]
    @line_offset = options[:line_offset]
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
      puts 'Error: input file or directory does not exist.'
    end
  rescue SystemExit, Interrupt
    puts 'The application stopped unexpectedly. The conversion may not have been completed.'
  end

  def convert(input_path)
    ass_file = vtt_to_ass(input_path)
    ass_file.write_to_file("#{@output}/#{File.basename(input_path).gsub('.vtt', '.ass')}") unless @output.nil?
    puts ass_file.to_s unless @quiet
  end

  ##
  # This method creates a new VTTFile object from the file path provided and convert its content
  # inside a new ASSFile object.
  def vtt_to_ass(file_path)
    base_file_name = File.basename(file_path).gsub('.vtt', '')
    css_file = if defined?(@css) && File.directory?(@css)
                 "#{@css}/#{base_file_name}.css"
               elsif File.file?("#{file_path.gsub('.vtt', '')}.css")
                 "#{file_path.gsub('.vtt', '')}.css"
               else
                 @css
               end
    vtt_file = VTTFile.new(file_path, @width, @height)
    ass_file = ASSFile.new(
      (defined?(@title) ? @title : base_file_name),
      @width,
      @height,
      css_file
    )
    ass_file.convert_vtt_to_ass(vtt_file, @font_family, @font_size, @line_offset)
    ass_file
  end
end
