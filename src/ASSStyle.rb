class ASSStyle
    attr_reader :style_name

    def initialize(style_name, params, width, height)
        @width = width
        @height = height
        @style_name = style_name
        assignParams(params)
    end
    def assignParams(params)
        # Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
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
    def to_s
        return "Style: #{@style_name},Open Sans Semibold,72.0,&H00FFFFFF,&H000000FF,&H00020713,&H00000000,-1,0,0,0,100,100,0,0,1,2.0,2.0,#{@alignment},#{@left_margin},#{@right_margin},#{@vertical_margin},1"
    end
end