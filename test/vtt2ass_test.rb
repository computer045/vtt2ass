require "test_helper"

class Vtt2assTest < Minitest::Test

  def setup
    @vtt_subtitle = VTTSubtitle.new("style\n00:01:31.084 --> 00:01:31.583 position:30% line:60% align:left\nVTT subtitle line")
    @ass_subtitle = ASSSubtitle.new(@vtt_subtitle.style, @vtt_subtitle.time_start, @vtt_subtitle.time_end, @vtt_subtitle.params, @vtt_subtitle.text)
    @ass_style = ASSStyle.new("style", "position:30% line:60% align:left", 'Open Sans Semibold', 50, 1920, 1080)
    @ass_file = ASSFile.new("file title",[@ass_style],[@ass_subtitle], 1920, 1080)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Vtt2ass::VERSION
  end

end
