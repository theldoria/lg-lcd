require_relative '../lib/lg-lcd'

LgLcd.connect("Ruby") do |ctx|
   puts "Connection: #{ctx.connection}"

   ctx.each_device do |dd|
      puts "Index: #{dd.index}"
      puts "Family id: #{dd.family_id}"
      puts "Display name: #{dd.display_name}"
      puts "Width: #{dd.width}"
      puts "Height: #{dd.height}"
      puts "Bpp: #{dd.bpp}"
      puts "Buttons: #{dd.num_soft_buttons}"

      dd.open do |device|
         puts "Device: #{device.device}"
         puts "Set as foreground app: #{device.set_as_lcd_foreground_app}"

         c = 0xFF
         dd.height.times do |y|
            dd.width.times do |x|
               dd.bitmap.draw_circle(x, y, y, c)
               c = c ^ 0xFF
               device.update_bitmap(dd.bitmap.data, LgLcd::Lib::LGLCD_PRIORITY_NORMAL)
               sleep(0.01)
            end
         end

         dd.height.times do |y|
            dd.width.times do |x|
#               dd.bitmap.data[:pixels][x + y * dd.width] = c
               dd.bitmap.set_pixel(x, y, c)
               c = c ^ 0xFF
            end
            c = c ^ 0xFF
         end
         device.update_bitmap(dd.bitmap.data, LgLcd::Lib::LGLCD_PRIORITY_NORMAL)
         sleep(1)
      end
   end
exit

   puts "-" * 40
   dd = LgLcd::Lib::DeviceDesc.new
   index = 0
   while 0 == ret = LgLcd::Lib.enumerate(ctx.connection, index, dd)
      puts "Index: #{index}"
      puts "Family id: #{dd[:family_id]}"
      puts "Display name: #{dd[:display_name]}"
      puts "Width: #{dd[:width]}"
      puts "Height: #{dd[:height]}"
      puts "Bpp: #{dd[:bpp]}"
      puts "Buttons: #{dd[:num_soft_buttons]}"
      index = index + 1
   end
   puts "Device: #{type_ctx.device}"
end

exit

LgLcd.connect("Ruby") do |ctx|
   puts "Connection: #{ctx.connection}"
   puts "-" * 40

   dd = LgLcd::Lib::DeviceDesc.new
   index = 0
   while 0 == ret = LgLcd::Lib.enumerate(ctx.connection, index, dd)
      puts "Index: #{index}"
      puts "Family id: #{dd[:family_id]}"
      puts "Display name: #{dd[:display_name]}"
      puts "Width: #{dd[:width]}"
      puts "Height: #{dd[:height]}"
      puts "Bpp: #{dd[:bpp]}"
      puts "Buttons: #{dd[:num_soft_buttons]}"
      index = index + 1
   end
   STDOUT.flush

   ctx.open do |type_ctx|
      puts "Device: #{type_ctx.device}"
      puts "-" * 20

      puts "Set as foreground app: #{LgLcd::Lib.set_as_lcd_foreground_app(type_ctx.device, LgLcd::Lib::LGLCD_LCD_FOREGROUND_APP_YES)}"

      if true
         bmp = LgLcd::Lib::Bitmap160x43x1.new
         bmp[:hdr][:format] = LgLcd::Lib::LGLCD_BMP_FORMAT_160x43x1
         c = 0xFF
         while true
            #            [0, LgLcd::Lib::LGLCD_BW_BMP_HEIGHT - 1].each do |y|
            LgLcd::Lib::LGLCD_BW_BMP_HEIGHT.times do |y|
               LgLcd::Lib::LGLCD_BW_BMP_WIDTH.times do |x|
                  bmp[:pixels][x + y * LgLcd::Lib::LGLCD_BW_BMP_WIDTH] = c
                  LgLcd::Lib.update_bitmap(type_ctx.device, bmp, LgLcd::Lib::LGLCD_PRIORITY_NORMAL)
                  sleep(0.01)
               end
            end
            c = c ^ 0xFF
         end
         [0, LgLcd::Lib::LGLCD_BW_BMP_WIDTH - 1].each do |x|
            LgLcd::Lib::LGLCD_BW_BMP_HEIGHT.times do |y|
               bmp[:pixels][x + y * LgLcd::Lib::LGLCD_BW_BMP_WIDTH] = c
               LgLcd::Lib.update_bitmap(type_ctx.device, bmp, LgLcd::Lib::LGLCD_PRIORITY_NORMAL)
               #                  sleep(0.1)
            end
         end
         puts "Update bitmap: #{LgLcd::Lib.update_bitmap(type_ctx.device, bmp, LgLcd::Lib::LGLCD_PRIORITY_NORMAL)}"

         sleep(2)
      end

      puts "-" * 20
   end

   puts "-" * 40
end
