##
# This class defines the ASS File that will be created from the conversion.
class ASSFile

    ##
    # This method creates an instance of the ASSFile.
    #
    # * Requires +ass_styles+, a list of ASSStyle as input.
    # * Requires +ass_subs+, a list of ASSSubtitles as input.
    # * Requires a video +width+ as input.
    # * Requires a video +height+ as input.
    def initialize(title, ass_styles, ass_subs, width, height)
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
        @ass_styles = ass_styles
        @events = [
            '',
            '[Events]',
            'Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text'
        ]
        @ass_subs = ass_subs
    end

    ##
    # This method concatenates the object data in the right order for a string output.
    def to_s
        return @header + @ass_styles + @events + @ass_subs
    end
end