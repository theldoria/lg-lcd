require 'ffi'
require_relative 'lib'
require_relative 'bitmap'

module LgLcd
   class Device
      attr_reader :context, :index, :family_id, :display_name, :width, :height, :bpp, :num_soft_buttons

      def initialize context, index, description
         @context = context
         @index = index
         @family_id = description[:family_id]
         @display_name = description[:display_name]
         @width = description[:width]
         @height = description[:height]
         @bpp = description[:bpp]
         @num_soft_buttons = description[:num_soft_buttons]
      end

      def bitmap
         unless @bitmap
            @bitmap = Bitmap.new(self)
         end

         return @bitmap
      end

      def open &block
         return context.open(@index, &block)
      end
   end
end
