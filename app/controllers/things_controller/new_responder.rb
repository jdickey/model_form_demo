
# ThingsController is our one and only demo controller.
class ThingsController < ApplicationController
  # Would encapsulate any business logic involved in `new` action.
  class NewResponder
    # Methods neither depending on nor affecting instance state
    module Internals
      # This would be our form object, if there were any business logic to it.
      def self.new_thing
        Thing.new
      end
    end
    private_constant :Internals

    # We don't use the controller in this action at present, but our Responder
    # classes all implement the same interface.
    def initialize(_controller)
      # @controller = controller
      self
    end

    # Dirt-simple. No failure mode; all it does is grab a new "thing" and yield
    # it to the block it was called with. (It *was* called with a block, WASN'T
    # IT?!?) Doesn't even set an instance variable; if anybody actually wants
    # the new thing, then the block we yield to is responsible for that.
    def call(_params = {}, &_block)
      thing = Internals.new_thing
      yield thing
      self
    end
  end # class ThingsController::NewResponder
end # class ThingsController
