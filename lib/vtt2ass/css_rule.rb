# frozen_string_literal: true

##
# This class defines a CSS rule that is included in the CSS file.
class CSSRule
  attr_reader :name, :properties

  def initialize(selector, declarations)
    @name = reduce_selector(selector)
    @properties = []
    declarations.split(/;\s?/).each do |dec|
      temp = dec.split(/:\s?/)
      @properties.push(
        { key: temp.first, value: temp.last }
      )
    end
  end

  def to_s
    "#{@name} #{@properties}"
  end

  ##
  # This method removes the generic selector from a block.
  def reduce_selector(selector)
    selector.to_s.gsub(
      /\.rmp-container>\.rmp-content>\.rmp-cc-area>\.rmp-cc-container>\.rmp-cc-display>\.rmp-cc-cue\s?\.?/, ''
    )
  end
end
