require_relative 'base'

module Semi::Variables
  class Boolean < Semi::Variables::Base


    def set(val)
      if val.instance_of? TrueClass
        @value = true
      elsif val.instance_of? FalseClass
        @value = false
      elsif val =~ /true|yes|on|enable/i
        # test to see if the value is a common true value
        @value = true
      elsif val =~ /false|no|off|disable/i
        # test to see if the value is a common false value
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

      # If Semi::Variables::Boolean, then get the string representation
      if value.class == Semi::Variables::Boolean
        value = value.to_s
      end
      
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

    def onoff
      if @value
        'on'
      else
        'off'
      end
    end

    def ONOFF
      onoff.upcase
    end

    def OnOff
      onoff.capitalize
    end


    def yesno()
      if @value
        'yes'
      else
        'no'
      end
    end

    def YESNO
      yesno.upcase
    end

    def YesNo
      yesno.capitalize
    end


    def enabledisable
      if @value
        'enable'
      else
        'disable'
      end
    end

    def ENABLEDISABLE
      enabledisable.upcase
    end

    def EnableDisable
      enabledisable.capitalize
    end


    def truefalse
      if @value
        'true'
      else
        'false'
      end
    end

    def TRUEFALSE
      truefalse.upcase
    end

    def TrueFalse
      truefalse.capitalize
    end
  end


end
