
# Class encapsulating all page-specific view code for `things/index`.
class Views::Things::Index < Views::Base
  # Widget implementing "Add Thing" button. (Isn't this pedantic, RuboCop?)
  class AddThingButton < Views::Base
    def content
      containing_widget { contained_widget }
    end

    private

    def contained_widget
      text 'Add New Thing'
    end

    def containing_widget
      button(content_attributes) { yield }
    end

    def content_attributes
      { type: 'button', class: 'btn btn-primary' }
    end
  end # class Views::Things::Index::AddThingButton
end # class Views::Things::Index
