
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    needs :thing, things_path: '/things', submit_button_text: 'Submit',
                  form_css_class: 'form-horizontal'

    def content
      outer_form do |builder|
        widget OuterFormControls, builder: builder
        builder.submit submit_button_text
      end
    end

    private

    def outer_form(&_block)
      form_for(:thing, outer_form_params) { |builder| yield builder }
    end

    def outer_form_params
      { url: things_path, html: { class: form_css_class } }
    end
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
