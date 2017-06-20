require_relative 'base'

module Semi::Variables
  class Path < Semi::Variables::Base

    @@path_re = Regexp.new('^(?<path>(?:\.{1,2}|\/).*?)\/(?<file>[^\/]+)?$')

    def validate
      self.validate(@value)
    end
    
    def self.validate(value)
      if ['String', 'Semi::Variables::Path'].include? value.class.to_s
        if @@path_re.match(value)
          return true
        end
      end
      false
    end
    
  end
end