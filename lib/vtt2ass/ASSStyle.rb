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
    def initialize(style_name, params, font_size, width, height)
        @width = width
        @height = height
        @font_size = font_size
        @style_name = style_name
        assignParams(params)
    end

    ##
    # This method converts the string of VTT styling in values used for ASS styling.
    #
    # * Requires +params+, a string of VTT styling as input.
    def assignParams(params)
        @alignment = "2"
        @left_margin = "10"
        @right_margin = "10"
        @vertical_margin = "50"

        if params.include? "align:middle line:7%" then
            @style_name = "MainTop"
            @vertical_margin = "30"
            @alignment = "8"
        else
            param_count = 0
            (params.split(' ').map { |p| p.split(':') }).each do |p|
                case p[0]
                when "position"
                    @left_margin = (@width * ((p[1].gsub(/%/, '').to_f - 7) / 100)).to_i.to_s
                when "align"
                    case p[1]
                    when "left"
                        @alignment = 1
                    when "middle"
                        @alignment = 2
                    when "right"
                        @alignment = 3
                    end
                when "line"
                    @vertical_margin = (@height - (@height * ((p[1].gsub(/%/, '').to_f + 7) / 100))).to_i.to_s
                end
                param_count += 1
            end
        end
    end
    
    ##
    # This method assigns the object values to an ASS style line and outputs it.
    def to_s
        return "Style: #{@style_name},Open Sans Semibold,#{@font_size},&H00FFFFFF,&H000000FF,&H00020713,&H00000000,-1,0,0,0,100,100,0,0,1,2.0,2.0,#{@alignment},#{@left_margin},#{@right_margin},#{@vertical_margin},1"
    end
end