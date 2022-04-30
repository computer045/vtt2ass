# Relative imports
require_relative 'VTTFile'
require_relative 'ASSFile'

##
# Main application class that manages all the operations.
class Application

    ##
    # Creates a new Application instance.
    # It receives +options+ that can define the input and output directories.
    def initialize(input, options)
        @input = input ? input.gsub('\\', '/').delete_suffix('/') : "."
        @output = options[:output] ? options[:output].gsub('\\', '/').delete_suffix('/') : nil
        @width = 1920
        @height = 1080
        @font_family = options[:font_family] ? options[:font_family] : 'Open Sans Semibold'
        @font_size = options[:font_size] ? options[:font_size] : 52
        if options[:title] then
            @title = options[:title]
        end
        @quiet = options[:quiet]
        if options[:css] then
            @css = options[:css].gsub('\\', '/')
        end
        @line_offset = options[:line_offset]
    end

    ##
    # This method starts the application process.
    # It sends the file_paths of VTT files in the input directory to convertFileToASS method
    # and outputs the resulting ASS format to a new file.
    def start
        if File.directory?(@input) then
            Dir["#{@input}/*.vtt"].each do |file_path|
                convert(file_path)
            end
        elsif File.file?(@input) then
            convert(@input)
        else
            puts 'Error: input file or directory does not exist.'
        end
    end

    def convert(input_path)
        ass_file = vtt_to_ass(input_path)
        if (not @output.nil?) then
            ass_file.writeToFile(@output + '/' + File.basename(input_path).gsub('.vtt', '.ass'))
        end
        puts ass_file.to_s unless @quiet
    end

    ##
    # This method creates a new VTTFile object from the file path provided and convert its content
    # inside a new ASSFile object.
    def vtt_to_ass(file_path)
        vtt_file = VTTFile.new(file_path, @width, @height)
        ass_file = ASSFile.new(
            (defined?(@title) ? @title : File.basename(file_path).gsub('.vtt', '')),
            @width,
            @height,
            defined?(@css) ? @css : nil
        )
        ass_file.convertVTTtoASS(vtt_file, @font_family, @font_size, @line_offset)
        return ass_file
    end

end