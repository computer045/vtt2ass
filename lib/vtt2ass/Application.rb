# Relative imports
require_relative 'VTTFile'
require_relative 'ASSFile'

##
# Main application class that manages all the operations.
class Application

    ##
    # Creates a new Application instance.
    # It receives +options+ that can define the input and output directories.
    def initialize(options)
        @input = options[:input] ? options[:input].gsub('\\', '/').delete_suffix('/') : "."
        @output = options[:output] ? options[:output].gsub('\\', '/').delete_suffix('/') : "."
        @width = 1920
        @height = 1080
        @font_family = options[:font_family] ? options[:font_family] : 'Open Sans Semibold'
        @font_size = options[:font_size] ? options[:font_size] : 52
        if options[:title] then
            @title = options[:title]
        end
    end

    ##
    # This method starts the application process.
    # It sends the file_paths of VTT files in the input directory to convertFileToASS method
    # and outputs the resulting ASS format to a new file.
    def start
        if File.directory?(@input) then
            Dir["#{@input}/*.vtt"].each do |file_path|
                vtt_to_ass(file_path).writeToFile(@output + '/' + File.basename(file_path).gsub('.vtt', '.ass'))
            end
        elsif File.file?(@input) then
            vtt_to_ass(@input).writeToFile(@output + '/' + File.basename(@input).gsub('.vtt', '.ass'))
        else
            puts 'Error: input file or directory does not exist.'
        end
    end

    ##
    # This method creates a new VTTFile object from the file path provided and convert its content
    # inside a new ASSFile object.
    def vtt_to_ass(file_path)
        vtt_file = VTTFile.new(file_path)
        ass_file = ASSFile.new(
            (defined?(@title) ? @title : File.basename(file_path).gsub('.vtt', '')),
            @width,
            @height
        )
        ass_file.convertVTTtoASS(vtt_file, @font_family, @font_size)
        return ass_file
    end

end