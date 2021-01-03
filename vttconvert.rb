require 'os'

def main  
    Dir["./input/*.vtt"].each do |file_path|
        file_name = File.basename(file_path).gsub('.vtt', '.ass')
        File.open('./output/' + file_name, 'w') do |line|
            line.print "\ufeff"
            line.puts convertFile(file_path)
        end
    end
end

def readVTTFile(file_path)
    list_parapraph = []
    separator = OS.linux? ? "\r\n\r\n": "\n\n"
    File.foreach(file_path, separator) do |paragraph|
        paragraph = paragraph.rstrip.gsub(/\r\n/, "\n")
        if not paragraph.eql? "" then
            list_parapraph.push(paragraph)
        end
    end
    list_parapraph.shift
    return list_parapraph
end

def convertFile(file_path)
    return convertToAss(readVTTFile(file_path))
end

def convertToAss(list_parapraph)
    # Style: Main,Open Sans Semibold,72.0,&H00FFFFFF,&H000000FF,&H00020713,&H00000000,-1,0,0,0,100,100,0,0,1,2.0,2.0,2,10,10,50,1
    # Style: MainTop,Open Sans Semibold,72.0,&H00FFFFFF,&H000000FF,&H00020713,&H00000000,-1,0,0,0,100,100,0,0,1,2.0,2.0,8,10,10,30,1

    width = 1920
    height = 1080

    styles = []
    rx = /^([\d:.]*) --> ([\d:.]*)\s?(.*?)\s*$/
    list_parapraph.each do |paragraph|
        lines = paragraph.split("\n")
        style = "Main"
        ext_param = ""
        count = 0
        lines.each do |line|
            m = line.match(rx)
            if not m and count == 0 then
                style = line
            elsif m then
                ext_param = m[3]
                break
            end
        end
        style_line = convertStyle(style, ext_param, width, height)
        style_exists = false
        styles.each do |s|
            if s.eql? style_line then
                style_exists = true
                break
            end
        end
        if (not style_exists) then
            styles.push(style_line)
        end
    end

    ass = [
        '[Script Info]',
        'Title: DKB Team',
        'ScriptType: v4.00+',
        'Collisions: Normal',
        'PlayDepth: 0',
        "PlayResX: #{width}",
        "PlayResY: #{height}",
        'WrapStyle: 0',
        'ScaledBorderAndShadow: yes',
        '',
        '[V4+ Styles]',
        'Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding',
    ]

    ass.append(styles)
    ass.append(
        [
            '',
            '[Events]',
            'Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text'
        ]
    )
    
    list_parapraph.each do |paragraph|
        paragraph = convertToAssLine(paragraph)
        ass = ass.append(paragraph)
    end
    
    return ass
end

def convertToAssLine(paragraph)
    lines = paragraph.split("\n")
    rx = /^([\d:.]*) --> ([\d:.]*)\s?(.*?)\s*$/
    style = "Main"
    line_text, time_start, time_end, ext_param = ""
    count = 0

    lines.each do |line|
        m = line.match(rx)
        if not m and count == 0 then
            style = line
        elsif m then
            time_start = convertTime(m[1])
            time_end = convertTime(m[2])
            ext_param = m[3]
            if ext_param.include? "align:middle line:7%" then
                style = "MainTop"
            end
        else
            line_text += convertToAssText(line)
        end
        count += 1;
    end

    return  "Dialogue: 0,#{time_start},#{time_end},#{style},,0,0,0,,#{line_text}"
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

def convertStyle(style, ext_param, width, height)
    # Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
    alignment = "2"
    left_margin = "10"
    right_margin = "10"
    vertical_margin = "50"

    if ext_param.include? "align:middle line:7%" then
        style = "MainTop"
        vertical_margin = "30"
        alignment = "8"
    else
        params = ext_param.split(' ').map { |p| p.split(':') }
        param_count = 0
        params.each do |p|
            case p[0]
            when "position"
                left_margin = (width * ((p[1].gsub(/%/, '').to_f - 7) / 100)).to_i.to_s
            when "align"
                case p[1]
                when "left"
                    alignment = 1
                when "middle"
                    alignment = 2
                when "right"
                    alignment = 3
                end
            when "line"
                vertical_margin = (height - (height * ((p[1].gsub(/%/, '').to_f + 7) / 100))).to_i.to_s
            end
            param_count += 1
        end
    end

    return "Style: #{style},Open Sans Semibold,72.0,&H00FFFFFF,&H000000FF,&H00020713,&H00000000,-1,0,0,0,100,100,0,0,1,2.0,2.0,#{alignment},#{left_margin},#{right_margin},#{vertical_margin},1"
end

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

main
