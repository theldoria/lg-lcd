require_relative 'lib'

module LgLcd
   class Open
      def initialize connection, device = 0
         if device.is_a?(Symbol)
            open_by_type(connection, device)
         else
            open_by_index(connection, device)
         end

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

      def set_as_lcd_foreground_app
         Lib.set_as_lcd_foreground_app(device, Lib::LGLCD_LCD_FOREGROUND_APP_YES)
      end

      def update_bitmap bitmap, priority
         Lib.update_bitmap(device, bitmap, priority)
      end

      private

      def open_by_index connection, index
         @ctx = Lib::OpenContext.new
         @ctx[:connection] = connection
         @ctx[:index] = index
         @ctx[:device] = Lib::LGLCD_INVALID_DEVICE
         raise "Open by index failed" unless Lib::LGLCD_RET_OK == Lib.open(@ctx)
      end

      def open_by_type connection, type
         @ctx = Lib::OpenByTypeContext.new
         @ctx[:connection] = connection
         @ctx[:device_type] = type
         @ctx[:device] = Lib::LGLCD_INVALID_DEVICE
         raise "Open by type failed" unless Lib::LGLCD_RET_OK == Lib.open_by_type(@ctx)
      end
   end
end
