require 'os'
require 'fileutils'
require_relative 'VTTSubtitle'
require_relative 'ASSSubtitle'
require_relative 'ASSStyle'
require_relative 'ASSFile'

class Application

    def initialize(options)
        @input_dir = options[:input] ? options[:input]: "./input"
        @output_dir = options[:output] ? options[:output]: "./output"
        @width = 1920
        @height = 1080
    end
    def start
        Dir["#{@input_dir}/*.vtt"].each do |file_path|
            file_name = File.basename(file_path).gsub('.vtt', '.ass')
            FileUtils.mkdir_p @output_dir
            File.open("#{@output_dir}/" + file_name, 'w') do |line|
                line.print "\ufeff"
                line.puts convertFileToASS(file_path)
            end
        end
    end

    def readVTTFile(file_path)
        list_parapraph = []
        separator = OS.linux? ? "\r\n\r\n": "\n\n"
        File.foreach(file_path, separator) do |paragraph|
            paragraph = paragraph.rstrip.gsub(/\r\n/, "\n")
            if not paragraph.eql? "" then
                list_parapraph.push(VTTSubtitle.new(paragraph))
            end
        end
        list_parapraph.shift
        return list_parapraph
    end

    def convertFileToASS(file_path)
        vtt_subs = readVTTFile(file_path)
        ass_subs = []
        ass_styles = []
        vtt_subs.each do |sub|
            ass_subs.push(ASSSubtitle.new(sub.style, sub.time_start, sub.time_end, sub.params, sub.text))
            style_exists = false
            ass_styles.each do |style|
                if (style.style_name == sub.style) then
                    style_exists = true
                    break
                end
            end
            if not style_exists then
                ass_styles.push(ASSStyle.new(sub.style, sub.params, @width, @height))
            end
        end
        return ASSFile.new(ass_styles, ass_subs, @width, @height).to_s
    end
end