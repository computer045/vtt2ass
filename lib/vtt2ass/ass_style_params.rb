# frozen_string_literal: true

##
# This class defines the ASS style parameters from VTT cue settings.
class ASSStyleParams
  attr_accessor :horizontal_margin, :vertical_margin, :alignment, :align

  ##
  # Creates an instance of ASSStyleParams
  # It takes VTT style arguments and assign them to their respectful instance variable.
  # It calls methods to create ASS values from the VTT cue settings.
  def initialize(params, width, height)
    split_params(params)
    create_alignment
    create_horizontal_margin(width)
    create_vertical_margin(height)
  end

  def split_params(params)
    (params.split(' ').map { |p| p.split(':') }).each do |p|
      case p[0]
      when 'position'
        @position = p[1].gsub(/%/, '').to_i
      when 'line'
        @line = p[1].gsub(/%/, '').to_i
        @line = @line == -1 ? 100 : @line
      when 'align'
        @align = p[1].chomp
      end
    end
  end

  ##
  # This method decides the alignement value in a 9 position grid based of the
  # values in cue settings "align" and "line".
  def create_alignment
    @alignment =
      if defined?(@line) && !defined?(@position)
        find_alignment(@align)
      elsif defined?(@line) && defined?(@position)
        1 # bottom left
      else
        find_default_alignment(@align)
      end
  end

  ##
  # This method returns alignment when "line" value is specified but not "position"
  def find_alignment(align)
    if !align.nil?
      case align
      when 'left', 'start'
        @line >= 50 ? 1 : 7
      when 'right', 'end'
        @line >= 50 ? 3 : 9
      when 'center', 'middle'
        @line >= 50 ? 2 : 8
      end
    else
      # If position is higher than 50% align to bottom center, else align to top center
      @line >= 50 ? 2 : 8
    end
  end

  ##
  # This method returns alignment when "line" and "position" values are not specified
  def find_default_alignment(align)
    case align
    when 'left', 'start'
      1
    when 'right', 'end'
      3
    when 'center', 'middle'
      2
    else
      2
    end
  end

  ##
  # This method calculates the horizontal margin in px between the alignement position and
  # and the content displayed by using the "position" cue setting.
  def create_horizontal_margin(width)
    steps = (width / 100).to_i
    @horizontal_margin =
      if defined?(@position)
        @position * steps
      else
        0
      end
  end

  ##
  # This method calculates the vertical margin in px between the alignement position and
  # and the content displayed by using the "line" cue setting.
  def create_vertical_margin(height)
    steps = (height / 100).to_i
    @vertical_margin =
      if defined?(@line)
        if @alignment == 1
          (100 - @line) * steps
        else
          @line >= 50 ? (100 - @line) * steps : @line * steps
        end
      else
        50
      end
  end
end
