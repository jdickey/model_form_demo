
require_relative 'flash_alert'

module Views
  module Things
    # Class encapsulating all page-specific view code for `things/index`.
    class Index < Views::Base
      # Shared layout-level widget to display all Rails flash messages neatly.
      class Flashes < Views::Base
        needs :flashes

        def content
          flashes.each_entry do |type, message|
            widget FlashAlert, message: message, type: type
          end
        end
      end # class Views::Things::Index::Flashes
    end
  end
end
