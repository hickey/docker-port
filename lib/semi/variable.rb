
require 'semi/variables/string'
require 'semi/variables/integer'
require 'semi/variables/boolean'
require 'semi/variables/path'
require 'semi/variables/url'

module Semi

  class VariableError < RuntimeError; end 

  module Variable

    def self.import(val)
      puts "#{val}: #{val.class}"
      # look for the obsure patterns before returning a string var
      case
      when Semi::Variables::Url::validate(val)
        return Semi::Variables::Url.new(val)
      when Semi::Variables::Path.validate(val)
        return Semi::Variables::Path.new(val)
      when Semi::Variables::Boolean.validate(val)
        return Semi::Variables::Boolean.new(val)
      when Semi::Variables::Integer.validate(val)
        return Semi::Variables::Integer.new(val)
      when val.class == Fixnum
        return Semi::Variables::Integer.new(val)
      when val.class == TrueClass
        return Semi::Variables::Boolean.new(val)
      when val.class == FalseClass
        return Semi::Variables::Boolean.new(val)
      else
        return Semi::Variables::String.new(val)
      end
      
    end

    


  end
end
