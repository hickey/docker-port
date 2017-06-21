require_relative 'base'

module Semi::Variables
  class Url < Semi::Variables::Base

    @@url_re = Regexp.new('^(?<proto>https?|ftp):\/{2}(?!\/)(?<host>[a-z\.0-9\-_]+)?(?::(?<port>\d{1,5}))?\/?(?<path>.*?)\/?(?<file>[^\/\?]+)?(?:\?(?<params>.*?))?$', Regexp::IGNORECASE)

    def initialize(val)
      if @@url_re.match(val)
        @value = val
      else
        raise Semi::VariableError, '#{val} does not look like a URL'
      end
    end

    def validate
      self.validate(@value)
    end

    def self.validate(val)
      if ['String', 'Semi::Variables::Url'].include? val.class.to_s
        if @@url_re.match(val.to_s)
          return true
        end
      end
      false
    end


    def proto
      match = @@url_re.match(@value)
      if match 
        match['proto']
      end
    end
    
    def host
      match = @@url_re.match(@value)
      if match 
        match['host']
      end
    end

    def port
      match = @@url_re.match(@value)
      if match 
        match['port']
      end
    end

    def path
      match = @@url_re.match(@value)
      if match 
        match['path']
      end
    end

    def file
      match = @@url_re.match(@value)
      if match 
        match['file']
      end
    end

    def params
      match = @@url_re.match(@value)
      if match 
        match['params']
      end
    end
  end
end
