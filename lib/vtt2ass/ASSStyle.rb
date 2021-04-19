# Relative imports
require_relative 'ASSStyleParams'

##
# This class defines an ASS style that can be applied on a subtitle line.
class ASSStyle
    attr_reader :style_name

    ##
    # This method creates and instance of an ASSStyle.
    #
    # * Requires +style_name+, a string name for the style as input.
    # * Requires +params+, a string of VTT styling as input.
    # * Requires a video +width+ as input.
    # * Requires a video +height+ as input. 
    def initialize(style_name, params, font_family, font_size, width, height)
        @width = width
        @height = height
        @font_family = font_family
        @font_size = font_size
        @style_name = style_name
        @s_params = ASSStyleParams.new(params, width, height)
        if style_name.eql? 'MainTop' then
            @s_params.vertical_margin = 50
        end
    end

    ##
    # This method assigns the object values to an ASS style line and outputs it.
    def to_s
        return "Style: #{@style_name},#{@font_family},#{@font_size},&H00FFFFFF,&H000000FF,&H00020713,&H00000000,-1,0,0,0,100,100,0,0,1,2.0,2.0,#{@s_params.alignment},#{@s_params.horizontal_margin},0,#{@s_params.vertical_margin},1"
    end
end