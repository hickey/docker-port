require_relative 'base'

module Semi::Variables
  class Integer < Semi::Variables::Base

    #def set(val)
    #  # test to see if the value is a common true value
    #  if value =~ /true|yes|enable/i
    #    @value = true
    #  elsif value =~ /false|no|disable/i
    #    @value = false
    #  else
    #    raise Semi::VariableError, "#{val} trying to be set as a boolean"
    #  end
    #end

    def validate
      self.validate(@value)
    end
    
    def self.validate(value)
      if value.class == Fixnum
        return true
      elsif value.class == Semi::Variables::Integer and value.to_s =~ /^\d+$/
        return true
      end
      false
    end

    def method_missing(m, *args, &block)
        @value.to_i.send(m, *args, &block)
      end
  end
end
