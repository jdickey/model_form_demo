
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    # Thing-name form label and entry controls.
    class NameContent < LabelledControl
      needs :builder, field_id: :name

      private

      def control_field
        builder.text_field field_id, type: 'text', class: control_css_class
      end
    end # class Views::Things::New::EntryForm::NameContent
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
