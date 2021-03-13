# Imports
require 'os'

# Relative imports
require_relative 'VTTLine'

##
# This class defines a VTT subtile file.
class VTTFile
    attr_accessor :lines

    def initialize(file_path)
        @title = File.basename(file_path).gsub('.vtt', '')
        @lines = []
        separator = OS.posix? ? "\r\n\r\n": "\n\n"
        File.foreach(file_path, separator) do |paragraph|
            paragraph = paragraph.rstrip.gsub(/\r\n/, "\n")
            if not paragraph.eql? "" then
                @lines.push(VTTLine.new(paragraph))
            end
        end
        @lines.shift
    end

    def writeToFile(file_path)
        File.open(file_path, 'w') do |line|
            line.print "\ufeff"
            line.puts self.to_s
        end
    end

    def to_s
        return "WEBVTT\n\n\n" + @lines 
    end

end