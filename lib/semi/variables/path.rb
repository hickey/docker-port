require_relative 'base'

module Semi::Variables
  class Path < Semi::Variables::Base

    @@path_re = Regexp.new('^(?<path>(?:\/|\.{1,2}\/|~(?:[a-z_][a-z0-9_]{0,30})?\/?|[^~][^\/\000]+\/)*?)(?<file>[^\/\000]+)?$')

    def initialize(val)
      if @@path_re.match(val)
        @value = val
      else
        raise Semi::VariableError, '#{val} does not look like a path'
      end
    end

    def validate
      self.validate(@value)
    end
    
    def self.validate(value)
      if ['String', 'Semi::Variables::Path'].include? value.class.to_s
        if @@path_re.match(value.to_s)
          return true
        end
      end
      false
    end
    
    def path
      match = @@path_re.match(@value)
      if match 
        match['path']
      end
    end

    def file
      match = @@path_re.match(@value)
      if match 
        match['file']
      end
    end

  end
end