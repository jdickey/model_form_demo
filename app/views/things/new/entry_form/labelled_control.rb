
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    # Base widget for form field label and entry controls
    class LabelledControl < Views::Base
      needs :builder, :field_id,
            label_css_class: 'control-class',
            control_css_class: 'form-control'

      def content
        label
        control_field
      end

      private

      def label
        builder.label field_id, class: label_css_class
      end

      def control_field
        message = "Must override LabelledControl#control_field.\n\n" \
                  "Example:\n" \
                  "def control_field\n" \
                  "  builder.text_field field_id, type: 'number',\n" \
                  "                               class: control_css_class\n" \
                  "end\n\n"
        raise NotImplementedError, message
      end
    end # class Views::Things::New::EntryForm::LabelledControl
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
