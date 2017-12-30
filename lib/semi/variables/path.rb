require_relative 'base'

module Semi::Variables
  class Path < Semi::Variables::Base

    @@path_re = Regexp.new('^(?<path>(?:\/|\.{1,2}\/|~(?:[a-z_][a-z0-9_]{0,30})?\/?|[^~][^\/\000]+\/)*?)(?<file>[^\/\000]+)?$')
    @@path_score_threshold = 0.200

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
          if path_score(value.to_s) > @@path_score_threshold
            return true
          end
        end
      end
      false
    end

    # provide a simple scoring method to assist in identifying
    # a string as a path. 0.0 is a pure string with no path
    # markers,
    def self.path_score(path)
      return 0.0 if path.empty?

      # use path "special" chars to calculate the score
      metach = path.count('/.~')
      plen = path.length
      #puts "#{path} m/p/s = #{metach}/#{plen}/#{1.0 - (((plen - metach) * 1.0) / (plen + metach))}"
      1.0 - (((plen - metach)*1.0) / (plen + metach))
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