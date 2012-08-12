require 'ffi'
require_relative 'lib'
require_relative 'open'

module LgLcd
   class Connection
      def initialize name
         @ctx = Lib::ConnectionContext.new
         @ctx[:app_friendly_name] = string_pointer(name)
         @ctx[:is_persistent] = false
         @ctx[:is_autostartable] = false
         @ctx[:connection] = Lib::LGLCD_INVALID_CONNECTION

         raise "Connecting failed" unless Lib::LGLCD_RET_OK == Lib.connect(@ctx)

         begin
            yield(self)
         ensure
            Lib.disconnect(connection)
         end
      end

      def connection
         return @ctx[:connection]
      end

      def open &block
         return Open.new(connection, &block)
      end

      private

      def string_pointer string
         mem_buf = FFI::MemoryPointer.new(:char, string.size)
         mem_buf.put_bytes(0, string)
         return mem_buf
      end
   end
end
