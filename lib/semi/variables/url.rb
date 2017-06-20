require_relative 'base'

module Semi::Variables
  class Url < Semi::Variables::Base

    @@url_re = Regexp.new('^(?<proto>https?|ftp|file):\/\/(?<host>[a-z\.0-9\-_]+)?(?::(?<port>\d{1,5}))?\/?(?<path>.*?)\/?(?<file>[^\/\?]+)?(?:\?(?<params>.*?))?$', Regexp::IGNORECASE)

    def validate
      self.validate(@value)
    end
    
    def self.validate(value)
      if ['String', 'Semi::Variables::Url'].include? value.class.to_s
        if @@url_re.match(value)
          return true
        end
      end
      false
    end
    
  end
end
