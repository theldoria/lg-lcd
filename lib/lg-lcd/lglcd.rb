require_relative 'lib'
require_relative 'connection'

module LgLcd
   class LgLcd
      def initialize
         raise "Initialization failed" unless Lib::LGLCD_RET_OK == Lib.init()

         begin
            yield(self)
         ensure
            Lib.deinit()
         end
      end

      def connect name, &block
         return Connection.new(name, &block)
      end
   end
end
