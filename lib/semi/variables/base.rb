
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
        @value
      end
      
    end
  end
end
