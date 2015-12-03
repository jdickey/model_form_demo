
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    # Thing-description form label and entry control.
    class DescriptionContent < LabelledControl
      needs :builder, field_id: :description, cols: 60, rows: 10

      private

      def control_field
        builder.text_area field_id, textarea_params
      end

      def textarea_params
        { type: 'text', class: label_css_class, cols: cols, rows: rows }
      end
    end # class Views::Things::New::EntryForm::DescriptionContext
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
