##
# This class defines a VTT subtile line.
class VTTLine
    attr_reader :style, :time_start, :time_end, :params, :text

    ##
    # This method creates an instance of an VTTLine.
    #
    # * Requires +paragraph+, a VTT formatted string as input.
    def initialize(paragraph)
        lines = paragraph.split("\n")
        rx = /^([\d:.]*) --> ([\d:.]*)\s?(.*?)\s*$/
        @style = "Main"
        @text, @time_start, @time_end, @params = ""
        count = 0

        lines.each do |line|
            m = line.match(rx)
            if not m and count == 0 then
                @style = line
            elsif m then
                @time_start = m[1]
                @time_end = m[2]
                @params = m[3]
                if @params.include? "align:middle line:7%" or @params.include? "align:middle line:10%" then
                    @style = "MainTop"
                end
            else
                @text += line + "\n"
            end
            count += 1;
        end
    end

    ##
    # This method assigns the object values and outputs a VTT dialogue line.
    def to_s
        return "#{@style} \n#{@time_start} --> #{@time_end} #{@params}\n#{@text}"
    end
end