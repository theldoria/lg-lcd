require_relative 'lib'

module LgLcd
   class Open
      def initialize connection
         @ctx = Lib::OpenByTypeContext.new
         @ctx[:connection] = connection
         @ctx[:device_type] = Lib::LGLCD_DEVICE_BW
         @ctx[:device] = Lib::LGLCD_INVALID_DEVICE
         raise "Open by type failes" unless Lib::LGLCD_RET_OK == Lib.open_by_type(@ctx)

         begin
            yield(self)
         ensure
            puts "Close"
            Lib.close(@ctx[:device])
         end
      end

      def device
         return @ctx[:device]
      end
   end
end
