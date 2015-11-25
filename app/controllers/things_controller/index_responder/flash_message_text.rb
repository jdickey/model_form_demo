
# ThingsController is our one and only demo controller.
class ThingsController < ApplicationController
  # Would encapsulate any business logic involved in index action: selection,
  # authorisation, and so on.
  class IndexResponder
    # Builds string to use for "success" flash message.
    class FlashMessageText
      def initialize(count:)
        @count = count
      end

      def to_s
        "There #{verb} currently #{count_str} #{item_str} in the system."
      end

      private

      attr_reader :count

      def count_str
        return 'no' if count.zero?
        count.to_s
      end

      def item_str
        'thing'.pluralize count
      end

      def verb
        return 'is' if count == 1
        'are'
      end
    end # class ThingsController::IndexResponder::FlashMessageText
  end # class ThingsController::IndexResponder
end # class ThingsController
