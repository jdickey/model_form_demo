
module Views
  module Things
    module Shared
      # Widget to display Rails flash messages neatly; should be shared widget.
      class FlashAlert < Views::Base
        needs :message, :type

        def content
          outer_widget do
            button_widget
            message_widget
          end
        end

        private

        def button_widget
          button(class: 'close', 'data-dismiss': 'alert') do
            rawtext '×'
          end
        end

        def message_widget
          tag_p message
        end

        def outer_widget
          div(container_attributes) { yield }
        end

        # used only by #container_attributes
        def alert_class
          alert_class_for(style_key) || type.to_s
        end

        # This method smells of :reek:UtilityFunction
        def alert_class_for(key)
          styles = {
            success:  'alert-success',
            error:    'alert-danger',
            alert:    'alert-warning',
            notice:   'alert-info'
          }
          styles[key]
        end

        # used only by #alert_class
        def style_key
          type.to_s.to_sym
        end

        # used only by #outer_widget
        def container_attributes
          alert_classes = "alert alert-dismissible #{alert_class}".rstrip
          { class: alert_classes, role: 'alert' }
        end
      end # class Views::Things::Shared::FlashAlert
    end
  end
end
