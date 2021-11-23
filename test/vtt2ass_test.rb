require "test_helper"

class Vtt2assTest < Minitest::Test

  def setup
    file_path = __dir__ + '/fixtures/Cute Executive Officer [1080p].vtt'
    @vtt_file = VTTFile.new(file_path, 1920, 1080)
    @ass_file = ASSFile.new(File.basename(file_path).gsub('.vtt', ''), 1920, 1080)
    @ass_file.convertVTTtoASS(@vtt_file, 'Open Sans Semibold', 52)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Vtt2ass::VERSION
  end

end
