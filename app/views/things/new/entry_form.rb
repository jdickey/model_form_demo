
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    needs :thing

    # This method has an :reek:UncommunicativeVariableName, and we're just fine.
    def content
      form_for(:thing) do |f|
        # f.legend 'Create a New Thing'
        widget TextControlAndLabel, field_id: :name, form_obj: f
        f.submit 'Submit'
      end
    end
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
