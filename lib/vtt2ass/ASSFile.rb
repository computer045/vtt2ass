# Relative imports
require_relative 'ASSLine'
require_relative 'ASSStyle'

##
# This class defines an ASS subtitle file.
class ASSFile
    attr_reader :title, :width, :height
    attr_accessor :ass_styles, :ass_lines

    ##
    # Creates a new ASSFile instance and assigns the default values of instance variables.
    def initialize(title, width, height)
        @width = width
        @height = height
        @header = [
            '[Script Info]',
            "Title: #{title}",
            'ScriptType: v4.00+',
            'Collisions: Normal',
            'PlayDepth: 0',
            "PlayResX: #{@width}",
            "PlayResY: #{@height}",
            'WrapStyle: 0',
            'ScaledBorderAndShadow: yes',
            '',
            '[V4+ Styles]',
            'Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding'
        ]
        @events = [
            '',
            '[Events]',
            'Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text'
        ]
        @ass_styles = []
        @ass_lines = []
    end

    ##
    # This method receives a VTTFile object and font arguments creates new ASSLine with the params of 
    # each VTTLine. All those ASSLine are stored in an array. It also creates an array of ASSStyle that
    # will be used in the ASS style list.
    def convertVTTtoASS(vtt_file, font_family, font_size)
        vtt_file.lines.each do |line|
            @ass_lines.push(ASSLine.new(line.style, line.time_start, line.time_end, line.text))
            style_exists = false
            @ass_styles.each do |style|
                if (style.style_name.eql? line.style) then
                    style_exists = true
                    break
                end
            end
            if not style_exists then
                @ass_styles.push(ASSStyle.new(line.style, line.params, font_family, font_size, @width, @height))
            end
        end
    end

    ##
    # This method writes the content of the ASSFile object into a file path that is provided.
    def writeToFile(file_path)
        File.open(file_path, 'w') do |line|
            line.print "\ufeff"
            line.puts self.to_s
        end
    end

    ##
    # This method concatenates the object data in the right order for a string output.
    def to_s
        return @header + @ass_styles + @events + @ass_lines
    end
end