require_relative 'base'

module Semi::Variables
  class Boolean < Semi::Variables::Base


    def set(val)
      # test to see if the value is a common true value
      if value =~ /true|yes|enable/i
        @value = true
      elsif value =~ /false|no|disable/i
        @value = false
      else
        raise Semi::VariableError, "#{val} trying to be set as a boolean"
      end
    end

    def validate
      self.validate(@value)
    end
    
    def self.validate(value)
      real_value = nil

      # test to see if the value is a common true value
      if value =~ /true|yes|enable/i
        real_value = true
      elsif value =~ /false|no|disable/i
        real_value = false
      end

      if !!real_value == real_value
        return true
      end
      false
    end
    
  end
end
