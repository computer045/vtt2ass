class ASSFile
    def initialize(ass_styles, ass_subs, width, height)
        @width = width
        @height = height
        @header = [
            '[Script Info]',
            'Title: DKB Team',
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
    def to_s
        return @header + @ass_styles + @events + @ass_subs
    end
end