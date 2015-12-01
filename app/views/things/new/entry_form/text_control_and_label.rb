
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    # NOTE: GENERIC text control/label widget combo
    class TextControlAndLabel < Views::Base
      needs :field_id, :form_obj, options: {}

      def content
        text_control_label
        text_control
      end

      private

      def controls_div
        div(class: 'controls') { yield }
      end

      def field_widget
        form_obj.text_field field_id, options
      end

      def text_control
        controls_div { field_widget }
      end

      def text_control_label
        form_obj.label field_id, class: 'control-label'
      end
    end # class Views::Things::New::EntryForm::TextControlAndLabel
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
