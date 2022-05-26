# Relative imports
require_relative 'vtt_line'

##
# This class defines a VTT subtile file.
class VTTFile
  attr_accessor :lines

  ##
  # Creates a new VTTFile instance and assigns the default values of instance variables.
  def initialize(file_path, width, height)
    @title = File.basename(file_path).gsub('.vtt', '')
    @lines = []
    separator = determine_line_ending(file_path) ? "\n\n" : "\r\n\r\n"
    count = 0
    style_count = 1
    File.foreach(file_path, separator) do |paragraph|
      paragraph = paragraph.rstrip.gsub(/[\r\n]/, "\n")
      if not paragraph.eql? "" then
        vtt_line = VTTLine.new(paragraph, width, height)
        if vtt_line.style.eql? 'Main' and
           not vtt_line.params.to_s.empty? and
           (not vtt_line.params.to_s.eql? 'align:middle' and
           not vtt_line.params.to_s.eql? 'align:center') then
          vtt_line.style = "Style#{style_count}"
          style_count += 1
        end
        @lines.push(vtt_line)
        count += 1
      end
    end
    @lines.shift
  end

  ##
  # This method determines the line ending character to use as a separator.
  def determine_line_ending(file_path)
    File.open(file_path, 'r') do |file|
      return file.readline[/\r?\n$/] == "\n"
    end
  end

  ##
  # This method writes the content of the VTTFile object into a file path that is provided.
  def write_to_file(file_path)
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
