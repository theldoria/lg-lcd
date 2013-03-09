require 'ffi'
require_relative 'lib'

module LgLcd
   class Bitmap
      def initialize device
         raise "Wrong device" unless device.width == 160
         @bitmap = Lib::Bitmap160x43x1.new
         @bitmap[:hdr][:format] = Lib::LGLCD_BMP_FORMAT_160x43x1
         @width = device.width
         @height = device.height
      end

      def set_pixel x, y, colour = 0xFF
         if x >= 0 and x <= @width and y >= 0 and y <= @height
            @bitmap[:pixels][x + y * @width] = colour
         end
      end

      def data
         return @bitmap
      end

      def draw_circle x, y, radius, colour = 0xFF
         set_pixel(x, y + radius, colour)
         set_pixel(x, y - radius, colour)
         set_pixel(x + radius, y, colour)
         set_pixel(x - radius, y, colour)

         f = 1 - radius
         ddF_x = 1
         ddF_y = -2 * radius
         x_ = 0
         y_ = radius
         while x_ < y_
            if f >= 0
               y_ -= 1
               ddF_y += 2
               f += ddF_y
            end
            x_ += 1
            ddF_x += 2
            f += ddF_x
            set_pixel(x + x_, y + y_, colour)
            set_pixel(x + x_, y - y_, colour)
            set_pixel(x - x_, y + y_, colour)
            set_pixel(x - x_, y - y_, colour)
            set_pixel(x + y_, y + x_, colour)
            set_pixel(x + y_, y - x_, colour)
            set_pixel(x - y_, y + x_, colour)
            set_pixel(x - y_, y - x_, colour)
         end
      end
   end
end
