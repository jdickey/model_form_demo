
require_relative 'flash_alert'

module Views
  module Things
    module Shared
      # Shared layout-level widget to display all Rails flash messages neatly.
      class Flashes < Views::Base
        needs :flashes

        def content
          render_other_flashes
          render_error_flashes
        end

        private

        def decoded_errors
          error_str = flashes[:error].to_s
          Views::Things::Shared::MessageEncoder.decode error_str
        end

        def other_flashes
          flashes.to_h.reject { |key, _value| key.to_sym == :error }
        end

        def render_alert(message:, type:)
          widget FlashAlert, message: message, type: type
        end

        def render_error_flashes
          decoded_errors.each do |message|
            render_alert message: message, type: :error
          end
        end

        def render_other_flashes
          other_flashes.each_entry do |type, message|
            render_alert message: message, type: type
          end
        end
      end # class Views::Things::Shared::Flashes
    end
  end
end
