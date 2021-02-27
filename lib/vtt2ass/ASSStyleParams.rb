##
# This class defines the ASS style parameters from VTT cue settings.
class ASSStyleParams
    attr_reader :horizontal_margin, :vertical_margin, :alignment

    def initialize(params, width, height)
        (params.split(' ').map { |p| p.split(':') }).each do |p|
            case p[0]
            when 'position'
                @position = p[1].gsub(/%/, '').to_i
            when 'line'
                @line = p[1].gsub(/%/, '').to_i
                @line = @line == -1 ? 100 : @line;
            when 'alignment'
                @align = p[1]
            end
        end
        createAlignment()
        createHorizontalMargin(width)
        createVerticalMargin(height)
    end

    def createAlignment
        if (defined?(@line) and not defined?(@position)) then
            if (defined?(@align)) then
                case @align
                when 'left'
                when 'start'
                    @alignment = @line >= 50 ? 1 : 7
                when 'right'
                when 'end'
                    @alignment = @line >= 50 ? 3 : 9
                when 'center'
                when 'middle'
                    @alignment = @line >= 50 ? 2 : 8
                end
            else
                @alignment = @line >= 50 ? 2 : 8 # If position is higher than 50% align to bottom center, else align to top center
            end
        elsif (defined?(@line) and defined?(@position)) then
            @alignment = 1
        else
            @alignment = 2
        end
    end

    def createHorizontalMargin(width)
        steps = (width / 100).to_i
        if defined?(@position) then
            @horizontal_margin = @position * steps
        else
            @horizontal_margin = 0
        end
    end

    def createVerticalMargin(height)
        steps = (height / 100).to_i
        if defined?(@line) then
            if (@alignment == 1) then
                @vertical_margin = (100 - @line) * steps
            else
                @vertical_margin = @line >= 50 ? (100 - @line) * steps : @line * steps
            end
        else
            @vertical_margin = 50
        end
    end
end