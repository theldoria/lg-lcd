require_relative "lg-lcd/lglcd"

module LgLcd
   def self.connect name
      LgLcd.new do |lg_lcd|
         lg_lcd.connect(name) do |context|
            yield(context)
         end
      end
   end

   def self.open name, *args
      connect(name) do |context|
         context.open(*args) do |type_context|
            yield(type_context, context)
         end
      end
   end
end
