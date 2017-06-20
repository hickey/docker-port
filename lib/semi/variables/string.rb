require_relative 'base'

module Semi::Variables
  class String < Semi::Variables::Base

    def validate
      self.validate(@value)
    end

    def self.validate(value)
      if value.class.to_s == 'String'
        return true
      end
      false
    end
    
  end
end
