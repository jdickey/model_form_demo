
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    # Simple Bootstrap-styled form group (NOT "input group"; see BS docs)
    class FormGroup < Views::Base
      needs :inner, css_classes: 'form-group'

      def content
        form_group { widget inner }
      end

      private

      def form_group
        div(class: css_classes) { yield }
      end
    end # class Views::Things::New::EntryForm::FormGroup
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
