
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    # Widget that renders form top-level control widgets (excluding buttons).
    class OuterFormControls < Views::Base
      needs :builder

      def content
        [NameContent, QuantityContent, DescriptionContent].each do |control|
          widget FormGroup, inner: control.new(builder: builder)
        end
      end
    end # class Views::Things::New::OuterForm
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
