
class Views::Things::Index < Views::Base
  class TableWidget < Views::Base
    # Generates table row with field values from a Thing instance in columns.
    class ThingDetailLine < Views::Base
      needs :thing

      def content
        tr { row_details }
      end

      private

      def columns_each
        thing.columns.each { |column| yield column }
      end

      def field_value_for(column)
        text string_value_for(column)
      end

      def string_value_for(column)
        thing.values[column].to_s
      end

      def row_details
        columns_each { |column| td_tag_for column }
        # thing.columns.each { |column| td_tag_for column }
      end

      def td_tag_for(column)
        td { field_value_for column }
      end
    end # class Views::Things::Index::TableWidget::ThingDetailLine
  end # class Views::Things::Index::TableWidget
end # class Views::Things::Index
