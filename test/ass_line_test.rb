require "test_helper"

class ASSLineTest < Minitest::Test
  def setup
    file_path = __dir__ + '/fixtures/example.vtt'
    vtt_file = VTTFile.new(file_path, 1920, 1080)
    @ass_file = ASSFile.new(File.basename(file_path).gsub('.vtt', ''), 1920, 1080)
    @ass_file.convert_vtt_to_ass(vtt_file, 'Open Sans Semibold', 52)
  end

  def test_ass_line_time_start_format
    assert_match (/\d:\d\d:\d\d.\d\d/), @ass_file.ass_lines[15].time_start
  end

  def test_ass_line_time_end_format
    assert_match (/\d:\d\d:\d\d.\d\d/), @ass_file.ass_lines[15].time_end
  end
end
