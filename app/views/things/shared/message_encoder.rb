
module Views
  module Things
    module Shared
      # Shared utility class (not really a widget) to encode/decode messages,
      # such as one or more error messages, into or from a single string.
      #   Decoding accounts for input that is either a simple string or an
      # encoded string representing either a simple string or an array of simple
      # strings; decoding always returns an array, even with a single element.
      #   Encoding permits input that is either a string or an array of strings;
      # it always returns a string.
      #
      # NOTE: This really *ought* to be completely separated from the view
      #       hierarchy.
      class MessageEncoder
        def self.encode(input)
          JSON.dump Array(input)
        end

        def self.decode(input)
          Array(JSON.load input)
        rescue JSON::ParserError
          Array(input.to_s)
        end
      end # class Views::Things::Shared::MessageEncoder
    end
  end
end
