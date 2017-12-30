require_relative 'base'

module Semi::Variables
  class String < Semi::Variables::Base

    def validate
      self.validate(@value)
    end

    def self.validate(value)
      if ['String', 'Semi::Variables::String'].include? value.class.to_s
        return true
      end
      false
    end

  end
end
