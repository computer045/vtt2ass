# Imports
require 'os'

# Relative imports
require_relative 'VTTSubtitle'
require_relative 'ASSSubtitle'
require_relative 'ASSStyle'
require_relative 'ASSFile'

##
# Main application class that manages all the operations.
class Application

    ##
    # Creates a new Application instance.
    # It receives +options+ that can define the input and output directories.
    def initialize(options)
        @input = options[:input] ? options[:input].gsub('\\', '/') : "./"
        @output = options[:output] ? options[:output].gsub('\\', '/') : "./"
        @width = 1920
        @height = 1080
        @font_size = options[:font_size] ? options[:font_size] : 52
    end

    ##
    # This method starts the application process.
    # It sends the file_paths of VTT files in the input directory to convertFileToASS method
    # and outputs the resulting ASS format to a new file.
    def start
        if File.directory?(@input) then
            Dir["#{@input}/*.vtt"].each do |file_path|
                writeFile(file_path)
            end
        elsif File.file?(@input) then
            writeFile(@input)
        else
            puts 'Error: input file or directory does not exist.'
        end
    end

    def writeFile(file_path)
        file_name = File.basename(file_path).gsub('.vtt', '.ass')
        File.open("#{@output}/" + file_name, 'w') do |line|
            line.print "\ufeff"
            line.puts convertFileToASS(file_path)
        end
    end

    ##
    # This method reads the VTT file and sends back a list of paragraphs.
    # It requires a +file_path+ as input.
    # It outputs a list named list_paragraph.
    def readVTTFile(file_path)
        list_parapraph = []
        separator = OS.posix? ? "\r\n\r\n": "\n\n"
        File.foreach(file_path, separator) do |paragraph|
            paragraph = paragraph.rstrip.gsub(/\r\n/, "\n")
            if not paragraph.eql? "" then
                list_parapraph.push(VTTSubtitle.new(paragraph))
            end
        end
        list_parapraph.shift
        return list_parapraph
    end

    ##
    # This method gets the list of paragraphs from the VTT file and creates lists of ASSSubtitle and ASSStyles objects from them.
    # Those lists are given a new ASSFile object to generate the file content.
    # It requires a +file_path+ as input.
    # It outputs an ASSFile object.
    def convertFileToASS(file_path)
        vtt_subs = readVTTFile(file_path)
        ass_subs = []
        ass_styles = []
        vtt_subs.each do |sub|
            ass_subs.push(ASSSubtitle.new(sub.style, sub.time_start, sub.time_end, sub.params, sub.text))
            style_exists = false
            ass_styles.each do |style|
                if (style.style_name == sub.style) then
                    style_exists = true
                    break
                end
            end
            if not style_exists then
                ass_styles.push(ASSStyle.new(sub.style, sub.params, @font_size, @width, @height))
            end
        end
        return ASSFile.new(File.basename(file_path).gsub('.vtt', ''), ass_styles, ass_subs, @width, @height).to_s
    end
end