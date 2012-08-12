require_relative '../lib/lg-lcd/lib'

LgLcd::LgLcd.new do |lg_lcd|
   puts "-" * 80

   lg_lcd.connect("Ruby") do |ctx|
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
   end
end
