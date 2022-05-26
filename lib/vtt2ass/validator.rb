class Validator
  def self.hex?(value)
    hex = true
    value.gsub!('#', '')
    value.chars.each do |digit|
      hex = false unless digit.match(/\h/)
    end
    return hex
  end
end
