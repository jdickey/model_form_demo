
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  # Form widget for 'things/new' action.
  class EntryForm < Views::Base
    needs :thing

    def content
      outer_form do |form_obj|
        # f.legend 'Create a New Thing'
        name_field_group form_obj
        quantity_field_group form_obj
        description_field_group form_obj
        form_obj.submit 'Submit'
      end
    end

    private

    def description_field_group(form_obj)
      form_group do
        label_for form_obj, :description
        form_obj.text_area :description, type: 'text', class: 'form-control',
                                         cols: 60, rows: 10
      end
    end

    def form_group
      div(class: 'form-group') { yield }
    end

    # This method smells of :reek:UtilityFunction; yeah, we know. Deal.
    def label_for(form_obj, field)
      form_obj.label field.to_sym, class: 'control-label'
    end

    def name_field_group(form_obj)
      form_group do
        widget TextControlAndLabel, field_id: :name, form_obj: form_obj
      end
    end

    def outer_form(&_block)
      form_for(:thing, html: { class: 'form-vertical' }) do |form_obj|
        yield form_obj
      end
    end

    def quantity_field_group(form_obj)
      form_group do
        label_for form_obj, :initial_quantity
        form_obj.text_field :initial_quantity, type: 'number',
                                               class: 'form-control'
      end
    end
  end # class Views::Things::New::EntryForm
end # class Views::Things::New
