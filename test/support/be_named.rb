
# Minitest custom matchers we've defined
module CustomMatchers
  # Minitest custom matcher for Ox node name.
  class NodeNameMatcher
    def initialize(name)
      @name = name
      self
    end

    def matches?(subject)
      subject.name == @name
    end

    def failure_message_for_should
      "expected to have a name of '#{@name}'"
    end

    def failure_message_for_should_not
      "expected not to have a name of '#{@name}'"
    end
  end # class CustomMatchers::NodeNameMatcher
end # module CustomMatchers

# This function smells of :reek:UtilityFunction -- why? It's not *in* a class!
def be_named(name)
  CustomMatchers::NodeNameMatcher.new name
end
MiniTest::Unit::TestCase.register_matcher :be_named, :be_named
