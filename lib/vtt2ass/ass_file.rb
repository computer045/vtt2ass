# Relative imports
require_relative 'ass_line'
require_relative 'ass_style'
require_relative 'css_file'
require_relative 'css_rule'

##
# This class defines an ASS subtitle file.
class ASSFile
    attr_reader :title, :width, :height
    attr_accessor :ass_styles, :ass_lines

    ##
    # Creates a new ASSFile instance and assigns the default values of instance variables.
    def initialize(title, width, height, css_file_path = nil)
        @width = width
        @height = height
        if not css_file_path.nil? then
            @css_file = CSSFile.new(css_file_path)
        end
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
    def convertVTTtoASS(vtt_file, font_family, font_size, line_offset = 0)
        fs = font_size
        vtt_file.lines.each do |line|
            font_color = '&H00FFFFFF'
            is_italic = false
            is_bold = false
            @ass_lines.push(ASSLine.new(line.style, line.time_start, line.time_end, line.text))
            style_exists = false
            @ass_styles.each do |style|
                if (style.style_name.eql? line.style) then
                    style_exists = true
                    break
                end
            end
            if not style_exists then
                if defined?(@css_file) then
                    css_rule = @css_file.find_rule(line.style)
                    if not css_rule.nil? then
                        css_rule.properties.each do |property|
                            case property[:key]
                            when 'font-family'
                                font_family = property[:value].gsub('"', '').split(' ,').last
                            when 'font-size'
                                em_size = 1
                                #em_size = property[:value][0].eql? '.' ? "0#{property[:value]}" : property[:value]
                                if property[:value][0].eql? '.' then
                                    em_size = "0#{property[:value]}".gsub('em', '').to_f
                                end
                                font_size = (fs * em_size).to_i
                            when 'color'
                                font_color = ASSStyle.convert_color(property[:value])
                            when 'font-weight'
                                if property[:value].eql? 'bold' then
                                    is_bold = true
                                end
                            when 'font-style'
                                if property[:value].eql? 'italic' then
                                    is_italic = true
                                end
                            end
                        end
                    end
                end
                @ass_styles.push(ASSStyle.new(line.style, line.params, font_family, font_size, font_color, is_bold, is_italic, line_offset, @width, @height))
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