
# ThingsController is our  one and only demo controller.
class ThingsController < ApplicationController
  # Would encapsulate any business logic involved in index action: selection,
  # authorisation, and so on.
  class IndexResponder
    def initialize(controller)
      @controller = controller
      self
    end

    def call(_params = {}, &_block)
      @things = Thing.all
      yield @things
      handle_success
      # failure is not a supported option
    end

    private

    attr_reader :controller, :things

    def handle_success
      controller.flash[:success] = 'Welcome to the app!'
      self
    end
  end # class ThingsController::IndexResponder
end
