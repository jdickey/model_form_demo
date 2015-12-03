
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    # Thing-initial-quantity form label and entry controls.
    class QuantityContent < LabelledControl
      needs :builder, field_id: :initial_quantity

      private

      def control_field
        builder.text_field field_id, type: 'number', class: control_css_class
      end
    end # class Views::Things::New::EntryForm::QuantityContent
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
