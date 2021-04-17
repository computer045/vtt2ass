# Relative imports
require_relative 'VTTLine'

##
# This class defines a VTT subtile file.
class VTTFile
    attr_accessor :lines

    ##
    # Creates a new VTTFile instance and assigns the default values of instance variables.
    def initialize(file_path)
        @title = File.basename(file_path).gsub('.vtt', '')
        @lines = []
        separator = determine_line_ending(file_path) ? "\n\n" : "\r\n\r\n"
        count = 0
        File.foreach(file_path, separator) do |paragraph|
            paragraph = paragraph.rstrip.gsub(/[\r\n]/, "\n")
            if not paragraph.eql? "" then
                vtt_line = VTTLine.new(paragraph)
                @lines.push(vtt_line)
                count += 1
            end
        end
        @lines.shift
    end

    def determine_line_ending(file_path)
        File.open(file_path, 'r') do |file|
            return file.readline[/\r?\n$/] == "\n"
        end
    end

    ##
    # This method writes the content of the VTTFile object into a file path that is provided.
    def writeToFile(file_path)
        File.open(file_path, 'w') do |line|
            line.print "\ufeff"
            line.puts self.to_s
        end
    end

    ##
    # This method concatenates the object data in the right order for a string output.
    def to_s
        return "WEBVTT\n\n\n" + @lines 
    end

end