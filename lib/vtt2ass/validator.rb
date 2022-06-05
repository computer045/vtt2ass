# frozen_string_literal: true

##
# This class defines validation tools for data.
class Validator
  def self.hex?(value)
    hex = true
    value.gsub!('#', '')
    value.chars.each do |digit|
      hex = false unless digit.match(/\h/)
    end
    hex
  end
end
