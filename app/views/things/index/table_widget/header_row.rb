
class Views::Things::Index < Views::Base
  class TableWidget < Views::Base
    # Generic table-header row; needs an array of symbolised field names.
    class HeaderRow < Views::Base
      # Methods that neither affect nor depend on instance state.
      module Internals
        def self.item_string(item)
          item.to_s.humanize.titlecase
        end
      end
      private_constant :Internals

      needs :fields

      def content
        tr { header_captions.each { |caption| item_widget caption } }
      end

      private

      def header_captions
        fields.map { |item| Internals.item_string(item) }
      end

      def item_widget(caption)
        th { text caption }
      end
    end # class Views::Things::Index::TableWidget::HeaderRow
  end # class Views::Things::Index::TableWidget
end # class Views::Things::Index
