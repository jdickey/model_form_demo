
require_relative 'table_widget/header_row'
require_relative 'table_widget/thing_detail_line'

class Views::Things::Index < Views::Base
  # Table widget used to display list of Thing instances' details.
  class TableWidget < Views::Base
    # If we wanted to be strictly correct wrt SRP, we wouldn't supply a default
    # for `detail_fields` here (especially since the default creates an ORM
    # instance).
    needs :things, detail_fields: Thing.new.columns

    def content
      containing_table do
        header_row_widget
        render_detail_lines
      end
    end

    private

    def containing_table
      table(class: 'table table-hover') { yield }
    end

    def header_row_widget
      widget HeaderRow, fields: detail_fields
    end

    def render_detail_lines
      things.each { |thing| widget ThingDetailLine, thing: thing }
    end
  end # class Views::Things::Index::TableWidget
end # class Views::Things::Index
