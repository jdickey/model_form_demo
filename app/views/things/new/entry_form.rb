
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    needs :thing

    def content
      outer_form do |builder|
        widget OuterFormControls, builder: builder
        builder.submit 'Submit'
      end
    end

    private

    def outer_form(&_block)
      form_for(:thing, html: { class: 'form-vertical' }) do |builder|
        yield builder
      end
    end
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
