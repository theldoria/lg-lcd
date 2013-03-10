# -*- coding: utf-8 -*-
require 'bdf'
require_relative '../lib/lg-lcd'

TEST_FILES_DIR = File.join(File.dirname(__FILE__), "test-files")
TEST_FILE_TOM = File.join(TEST_FILES_DIR, "tom-thumb.bdf")
TEST_FILE_EXAMPLE1 = File.join(TEST_FILES_DIR, "example1.bdf")

LgLcd.connect("Ruby2") do |ctx|
  puts "Connection: #{ctx.connection}"

  ctx.each_device do |dd|
    puts "Index: #{dd.index}"
    puts "Family id: #{dd.family_id}"
    puts "Display name: #{dd.display_name}"
    puts "Width: #{dd.width}"
    puts "Height: #{dd.height}"
    puts "Bpp: #{dd.bpp}"
    puts "Buttons: #{dd.num_soft_buttons}"

    @bdf = Bdf.load(TEST_FILE_TOM)
    bbx = @bdf.bounding_box
    screen = @bdf.create_bounding_box_array(160, 43)
    keys = @bdf.chars.keys.reverse
    ly = 0
    7.times do |row|
      x = 0
      y = bbx[:y] * row
      40.times do
        _, x, ly = @bdf.print_char(screen, keys.pop, x, y) if keys.length > 0
      end
    end
    x = 0
    y = ly + bbx[:y]
    @bdf.print(screen, "That's all! #{Time.now}", x, y)

    dd.open do |device|
      puts "Device: #{device.device}"
      puts "Set as foreground app: #{device.set_as_lcd_foreground_app}"

      c = 0xFF
      screen.each_with_index do |a, y|
        a.each_with_index do |b, x|
          if b
            dd.bitmap.set_pixel(x, y, c)
          else
            dd.bitmap.set_pixel(x, y, 0)
          end
        end
      end
      device.update_bitmap(dd.bitmap.data, LgLcd::Lib::LGLCD_PRIORITY_NORMAL)

      sleep(10)
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
