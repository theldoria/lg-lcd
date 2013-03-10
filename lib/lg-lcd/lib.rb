require 'ffi'

module LgLcd
   module Lib
      extend FFI::Library

      LGLCD_RET_OK = 0

      # Invalid handle definitions
      LGLCD_INVALID_CONNECTION = -1
      LGLCD_INVALID_DEVICE     = -1

      # Common Soft-Buttons available through the SDK
      LGLCDBUTTON_LEFT                    = 0x00000100
      LGLCDBUTTON_RIGHT                   = 0x00000200
      LGLCDBUTTON_OK                      = 0x00000400
      LGLCDBUTTON_CANCEL                  = 0x00000800
      LGLCDBUTTON_UP                      = 0x00001000
      LGLCDBUTTON_DOWN                    = 0x00002000
      LGLCDBUTTON_MENU                    = 0x00004000

      # Soft-Button masks. Kept for backwards compatibility
      LGLCDBUTTON_BUTTON0                 = 0x00000001
      LGLCDBUTTON_BUTTON1                 = 0x00000002
      LGLCDBUTTON_BUTTON2                 = 0x00000004
      LGLCDBUTTON_BUTTON3                 = 0x00000008
      LGLCDBUTTON_BUTTON4                 = 0x00000010
      LGLCDBUTTON_BUTTON5                 = 0x00000020
      LGLCDBUTTON_BUTTON6                 = 0x00000040
      LGLCDBUTTON_BUTTON7                 = 0x00000080

      # Bitmap
      LGLCD_BMP_FORMAT_160x43x1           = 0x00000001
      LGLCD_BMP_FORMAT_QVGAx32            = 0x00000003
      LGLCD_BW_BMP_WIDTH                  = 160
      LGLCD_BW_BMP_HEIGHT                 = 43
      LGLCD_BW_BMP_BPP                    = 1
      LGLCD_QVGA_BMP_WIDTH                = 320
      LGLCD_QVGA_BMP_HEIGHT               = 240
      LGLCD_QVGA_BMP_BPP                  = 4

      # Priorities
      LGLCD_PRIORITY_IDLE_NO_SHOW                 = 0
      LGLCD_PRIORITY_BACKGROUND                   = 64
      LGLCD_PRIORITY_NORMAL                       = 128
      LGLCD_PRIORITY_ALERT                        = 255
      LGLCD_SYNC_UPDATE                           = 0x80000000
      LGLCD_SYNC_COMPLETE_WITHIN_FRAME            = 0xC0000000
      LGLCD_ASYNC_UPDATE                          = 0

      # Foreground mode for client applications
      LGLCD_LCD_FOREGROUND_APP_NO                 = 0
      LGLCD_LCD_FOREGROUND_APP_YES                = 1

      # Device family definitions
      LGLCD_DEVICE_FAMILY_BW_160x43_GAMING        = 0x00000001
      LGLCD_DEVICE_FAMILY_KEYBOARD_G15            = 0x00000001
      LGLCD_DEVICE_FAMILY_BW_160x43_AUDIO         = 0x00000002
      LGLCD_DEVICE_FAMILY_SPEAKERS_Z10            = 0x00000002
      LGLCD_DEVICE_FAMILY_JACKBOX                 = 0x00000004
      LGLCD_DEVICE_FAMILY_BW_160x43_BASIC         = 0x00000008
      LGLCD_DEVICE_FAMILY_LCDEMULATOR_G15         = 0x00000008
      LGLCD_DEVICE_FAMILY_RAINBOW                 = 0x00000010
      LGLCD_DEVICE_FAMILY_QVGA_BASIC              = 0x00000020
      LGLCD_DEVICE_FAMILY_QVGA_GAMING             = 0x00000040
      LGLCD_DEVICE_FAMILY_GAMEBOARD_G13           = 0x00000080
      LGLCD_DEVICE_FAMILY_KEYBOARD_G510           = 0x00000100
      LGLCD_DEVICE_FAMILY_OTHER                   = 0x80000000

      # Combinations of device families (device clans?)
      LGLCD_DEVICE_FAMILY_ALL_BW_160x43           = (LGLCD_DEVICE_FAMILY_BW_160x43_GAMING |
         LGLCD_DEVICE_FAMILY_BW_160x43_AUDIO |
         LGLCD_DEVICE_FAMILY_JACKBOX |
         LGLCD_DEVICE_FAMILY_BW_160x43_BASIC |
         LGLCD_DEVICE_FAMILY_RAINBOW |
         LGLCD_DEVICE_FAMILY_GAMEBOARD_G13 |
         LGLCD_DEVICE_FAMILY_KEYBOARD_G510)

      LGLCD_DEVICE_FAMILY_ALL_QVGA                = (LGLCD_DEVICE_FAMILY_QVGA_BASIC |
         LGLCD_DEVICE_FAMILY_QVGA_GAMING)

      LGLCD_DEVICE_FAMILY_ALL                     = (LGLCD_DEVICE_FAMILY_ALL_BW_160x43 |
         LGLCD_DEVICE_FAMILY_ALL_QVGA)

      # Capabilities of applets connecting to LCD Manager.
      LGLCD_APPLET_CAP_BASIC                          = 0x00000000
      LGLCD_APPLET_CAP_BW                             = 0x00000001
      LGLCD_APPLET_CAP_QVGA                           = 0x00000002

      # Notifications sent by LCD Manager to applets connected to it.
      LGLCD_NOTIFICATION_DEVICE_ARRIVAL               = 0x00000001
      LGLCD_NOTIFICATION_DEVICE_REMOVAL               = 0x00000002
      LGLCD_NOTIFICATION_CLOSE_CONNECTION             = 0x00000003
      LGLCD_NOTIFICATION_APPLET_DISABLED              = 0x00000004
      LGLCD_NOTIFICATION_APPLET_ENABLED               = 0x00000005
      LGLCD_NOTIFICATION_TERMINATE_APPLET             = 0x00000006

      # Device types used in notifications
      LGLCD_DEVICE_BW                                 = 0x00000001
      LGLCD_DEVICE_QVGA                               = 0x00000002

      # From WinDef.h
      MAX_PATH = 260

      # struct lgLcdConfigureContext
      class ConfigureContext < FFI::Struct
         layout config_callback: :pointer,
         config_context: :pointer
      end

      # struct lgLcdNotificationContext
      class NotificationContext < FFI::Struct
         layout notification_callback: :pointer,
         notification_context: :pointer
      end

      # struct lgLcdConnectContextExA
      class ConnectionContext < FFI::Struct
         # "Friendly name" display in the listing
         # LPCSTR
         layout app_friendly_name: :pointer,
         # isPersistent determines whether this connection persists in the list
         is_persistent: :bool,
         # isAutostartable determines whether the client can be started by
         # LCDMon
         is_autostartable: :bool,
         on_configure: ConfigureContext,
         # Need this x, otherwise connection is not filled.
         # Possibly a padding problem...
         x: :int,
         # --> Connection handle
         connection: :int,
         # Or'd combination of LGLCD_APPLET_CAP_... defines
         applet_capabilities_supported: :long,
         reserved: :long,
         on_notify: NotificationContext
      end

      # struct lgLcdDeviceDescExA
      class DeviceDesc < FFI::Struct
         layout family_id: :long,
         display_name: [:uint8, MAX_PATH],
         width: :long,
         height: :long,
         bpp: :long,
         num_soft_buttons: :long,
         reserved1: :long,
         reserved2: :long
      end

      class SoftbuttonsChangedContext < FFI::Struct
         # Set to NULL if no softbutton notifications are needed
         layout softbuttons_changed_callback: :pointer,
         softbuttons_changed_context: :pointer
      end

      class OpenContext < FFI::Struct
         layout connection: :int,
         # Index of device to open
         index: :int,
         on_softbuttons_changed: SoftbuttonsChangedContext,
         # --> Device handle
         device: :int
      end

      class OpenByTypeContext < FFI::Struct
         layout connection: :int,
         # Device type to open (either LGLCD_DEVICE_BW or LGLCD_DEVICE_QVGA)
         device_type: :int,
         on_softbuttons_changed: SoftbuttonsChangedContext,
         # --> Device handle
         device: :int
      end

      class BitmapHeader < FFI::Struct
         layout format: :long
      end

      class Bitmap160x43x1 < FFI::Struct
         layout hdr: BitmapHeader, # LGLCD_BMP_FORMAT_160x43x1
         pixels: [:uint8, LGLCD_BW_BMP_WIDTH * LGLCD_BW_BMP_HEIGHT * LGLCD_BW_BMP_BPP]
      end

      ffi_lib File.join(File.dirname(__FILE__), '..\..\ext\LgLcdDll')
      ffi_convention :stdcall

      attach_function :init, :lgLcdInit, [], :long
      attach_function :deinit, :lgLcdDeInit, [], :long

      attach_function :connect, :lgLcdConnectExA, [:pointer], :long
      attach_function :disconnect, :lgLcdDisconnect, [:int], :long

      attach_function :open, :lgLcdOpen, [:pointer], :long
      attach_function :open_by_type, :lgLcdOpenByType, [:pointer], :long
      attach_function :close, :lgLcdClose, [:int], :long

      attach_function :set_as_lcd_foreground_app, :lgLcdSetAsLCDForegroundApp, [:int, :int], :long
      attach_function :update_bitmap, :lgLcdUpdateBitmap, [:int, :pointer, :long], :long

      # Deprecated
      attach_function :enumerate, :lgLcdEnumerateExA, [:int, :int, :pointer], :long
   end
end
