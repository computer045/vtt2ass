require "test_helper"

class ASSStyleTest < Minitest::Test

    def setup
        file_path = __dir__ + '/fixtures/example.vtt'
        vtt_file = VTTFile.new(file_path, 1920, 1080)
        @ass_file = ASSFile.new(File.basename(file_path).gsub('.vtt', ''), 1920, 1080)
        @ass_file.convertVTTtoASS(vtt_file, 'Open Sans Semibold', 52)
    end
    
end