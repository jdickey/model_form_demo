
require_relative 'index_responder/flash_message_text'

# ThingsController is our one and only demo controller.
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

    def flash_message
      FlashMessageText.new(count: things.count).to_s
    end

    def handle_success
      controller.flash[:success] = flash_message
      self
    end
  end # class ThingsController::IndexResponder
end
