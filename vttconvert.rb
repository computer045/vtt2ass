def main
    Dir["./input/*.vtt"].each do |file_path|
        convertFile(file_path)
        file_name = File.basename(file_path).gsub('.vtt', '.ass')
        File.open('./output/' + file_name, 'w') do |line|
            line.print "\ufeff"
            line.puts convertFile(file_path)
        end
    end
end

def get_file_as_string(file_path)
    data = ''
    f = File.readlines(file_path).each do |line|
        data += line
    end
    return data
end

def convertFile(file_path)
    return convertToAss(get_file_as_string(file_path))
end

def convertToAss(vttStr)
    ass = [
        '[Script Info]',
        'Title: DKB Team',
        'ScriptType: v4.00+',
        'Collisions: Normal',
        'PlayDepth: 0',
        'PlayResX: 1920',
        'PlayResY: 1080',
        'WrapStyle: 0',
        'ScaledBorderAndShadow: yes',
        '',
        '[V4+ Styles]',
        'Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding',
        'Style: Main,Open Sans Semibold,72.0,&H00FFFFFF,&H000000FF,&H00020713,&H00000000,-1,0,0,0,100,100,0,0,1,2.0,2.0,2,10,10,50,1',
        'Style: MainTop,Open Sans Semibold,72.0,&H00FFFFFF,&H000000FF,&H00020713,&H00000000,-1,0,0,0,100,100,0,0,1,2.0,2.0,8,10,10,30,1',
        '',
        '[Events]',
        'Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text'
    ]
    
    vttData = loadVtt(vttStr)
    vttData.each do |l|
        l = convertToAssLine(l, 'Main')
        ass = ass.append(l)
    end
    
    return ass
end

def loadVtt(vttStr)
    rx = /^([\d:.]*) --> ([\d:.]*)\s?(.*?)\s*$/
    lines = vttStr.gsub(/\r?\n/, '\n').split('\n')
    data = []
    lineBuf = []
    record = nil

    # check  lines
    lines.each do |l|
        m = l.match(rx)
        if (m) then
            if (lineBuf.length > 0) then
                lineBuf.pop()
            end
            if record != nil then
                record['text'] = lineBuf.join('\n')
                data.push(record)
            end
            record = {
                'time_start' => m[1],
                'time_end' => m[2],
                'ext_param' => m[3].split(' ').map{ |x| x.split(':')}
            }
            lineBuf = []
            next
        end
        lineBuf.push(l)
    end
    if (record != nil) then
        if (lineBuf[lineBuf.length - 1].empty?) then
            lineBuf.pop()
        end
        record['text'] = lineBuf.join('\n')
        data.push(record)
    end
    return data
end

def convertToAssLine(l, style)
    time_start = convertTime(l['time_start'])
    time_end = convertTime(l['time_end'])
    line_text = convertToAssText(l['text'])

    l['ext_param'].each do |param|
        if param.include?('line') && param.include?('7%') then
            style = 'MainTop'
        end
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
        .gsub(/<[^>]>/, '')
        .gsub(/\\N$/, '')
        .gsub(/ +$/, '')

    return text
end

def convertTime(time)
    mTime = time.match(/([\d:]*)\.?(\d*)/)
    return toSubsTime(mTime[0])
end

def toSubsTime(str)
    n = []
    x = str.split(/[:.]/).map { |x| x.to_f }
    
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
