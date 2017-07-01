
require 'semi/variables/string'
require 'semi/variables/integer'
require 'semi/variables/boolean'
require 'semi/variables/path'
require 'semi/variables/url'


module Semi

  class VariableError < RuntimeError; end 

  module Variable

    # Variable types are ordered from most to least specific
    @@var_types = { 'url'       =>   Semi::Variables::Url,
                    'path'      =>   Semi::Variables::Path,
                    'boolean'   =>   Semi::Variables::Boolean,
                    'integer'   =>   Semi::Variables::Integer,
                    'string'    =>   Semi::Variables::String, }

    def self.import(val, hints=nil)
      # If hints have been supplied, try to create from them
      unless hints.nil?
        hints = [hints].flatten.select {|h| @@var_types.include? h }
        if hints.count > 0
          return @@var_types[hints[0]].new(val)
        end
      end
      
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


    def self.expand(val, dict)
      unless ['Semi::Variables::String', 'String'].include? val.class.to_s
        return val
      end
      
      check = true
      while check
        # Look for simple variable expansion
        if match = /\$\{?(\w+)\}?/.match(val)
          val = match.pre_match + dict[match[1].downcase] + match.post_match
        elsif match = /\$\((.*)\)/.match(val)
          val = match.pre_match + `#{match[1]} 2>/dev/null` + match.post_match
        else
          # no more matches... we must be done...
          check = false
        end
      end
      
      return val
    end

  end
end
