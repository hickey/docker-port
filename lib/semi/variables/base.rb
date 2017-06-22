
module Semi
  module Variables
    class Base

      def initialize(val)
        set(val)
      end

      def set(val)
        @value = val
      end

      def to_s
        @value.to_s
      end

      def value
        @value
      end
      
      def &(other)
        return @value & other
      end

      def |(other)
        return @value | other
      end

      def <=>(other)
        return @value <=> other
      end

      def eql?(other)
        return @value.eql? other
      end

      def equal?(other)
        return @value.equal? other
      end

      def ^(other)
        return @value ^ other
      end

      def !=(other)
        return @value != other
      end

      def ==(other)
        return @value == other
      end

      def ===(other)
        return @value === other
      end

      def =~(other)
        return @value =~ other
      end

      def !~(other)
        return @value != other
      end


      def method_missing(m, *args, &block)
        @value.to_s.send(m, *args, &block)
      end
      
    end
  end
end
