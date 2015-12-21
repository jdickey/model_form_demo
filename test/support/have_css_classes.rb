
# Minitest custom matchers we've defined
module CustomMatchers
  # Minitest custom matcher for Ox node :class attributes.
  class NodeCssClassMatcher
    def initialize(names)
      @names = Array(names)
      self
    end

    def matches?(subject)
      @actual = subject[:class].split
      @actual == @names
    end

    def failure_message_for_should
      "expected to have CSS classes of '#{@names}'; had '#{@actual}'."
    end

    def failure_message_for_should_not
      "expected not to have CSS classes of '#{@names}'"
    end
  end # class CustomMatchers::NodeCssClassMatcher
end # module CustomMatchers

# This function smells of :reek:UtilityFunction -- why? It's not *in* a class!
def have_css_classes(names) # rubocop:disable Style/PredicateName
  CustomMatchers::NodeCssClassMatcher.new names
end
MiniTest::Unit::TestCase.register_matcher :have_css_classes, :have_css_classes
