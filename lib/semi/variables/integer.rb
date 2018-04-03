require_relative 'base'

module Semi::Variables
  class Integer < Semi::Variables::Base

    def validate
      self.validate(@value)
    end

    def self.validate(value)
      if value.class == 1.class
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
