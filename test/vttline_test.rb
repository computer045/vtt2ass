require "test_helper"

class VTTLineTest < Minitest::Test
   
    def setup
        file_path = __dir__ + '/fixtures/example.vtt'
        @vtt_file = VTTFile.new(file_path, 1920, 1080)
    end

    def test_that_vtt_line_is_instance_of_VTTLine
        assert_instance_of VTTLine, @vtt_file.lines[0]
    end
    
    def test_vtt_line_time_start_format
        assert_match (/([\d:]*)\.?(\d*)/), @vtt_file.lines[0].time_start
    end
    
    def test_vtt_line_time_end_format
        assert_match (/([\d:]*)\.?(\d*)/), @vtt_file.lines[0].time_end
    end
    
    def test_vtt_line_style_not_empty
        refute_empty @vtt_file.lines[0].style
    end
    
    def test_vtt_line_text_not_empty
        refute_empty @vtt_file.lines[0].text
    end

end