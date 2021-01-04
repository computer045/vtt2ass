class ASSSubtitle
    attr_reader :style, :time_start, :time_end, :params, :text
    
    def initialize(style, time_start, time_end, params, text)
        @style = style
        @time_start = convertTime(time_start)
        @time_end = convertTime(time_end)
        @params = params
        @text = convertToAssText(text)
    end

    def to_s()
        return "Dialogue: 0,#{@time_start},#{@time_end},#{@style},,0,0,0,,#{@text}"
    end

    def convertToAssText(text)
        text = text
            .gsub(/\r/, '')
            .gsub(/\n/, '\\N')
            .gsub(/\\n/, '\\N')
            .gsub(/\\N +/, '\\N')
            .gsub(/ +\\N/, '\\N')
            .gsub(/(\\N)+/, '\\N')
            .gsub(/<b[^>]*>([^<]*)<\/b>/) { |s| "{\\b1}#{$1}{\\b0}" }
            .gsub(/<i[^>]*>([^<]*)<\/i>/) { |s| "{\\i1}#{$1}{\\i0}" }
            .gsub(/<u[^>]*>([^<]*)<\/u>/) { |s| "{\\u1}#{$1}{\\u0}" }
            .gsub(/<c[^>]*>([^<]*)<\/c>/) { |s| $1 }
            .gsub(/<[^>]>/, '')
            .gsub(/\\N$/, '')
            .gsub(/ +$/, '')
        return text
    end

    # Methods
    def convertTime(time)
        mTime = time.match(/([\d:]*)\.?(\d*)/)
        return toSubsTime(mTime[0])
    end
    
    def toSubsTime(str)
        n = []
        x = str.split(/[:.]/).map { |x| x.to_i }
        
        msLen = 2
        hLen = 1
        
        x[3] = '0.' + (x[3].to_s).rjust(3, '0')
        sx = x[0]*60*60 + x[1]*60 + x[2] + x[3].to_f
        sx = ("%.2f" % sx).split('.')
    
        n.unshift(padTimeNum('.', sx[1], msLen))
        sx = sx[0].to_f
    
        n.unshift(padTimeNum(':', (sx % 60).to_i, 2))
        n.unshift(padTimeNum(':', (sx / 60).floor % 60, 2))
        n.unshift(padTimeNum('',  (sx / 3600).floor % 60, hLen))
    
        return n.join('')
    end
    
    def padTimeNum(sep, input, pad)
        return sep + (input.to_s).rjust(pad, '0')
    end
end