
require_relative 'index_responder/flash_message_text'

# ThingsController is our one and only demo controller.
class ThingsController < ApplicationController
  # Would encapsulate any business logic involved in index action: selection,
  # authorisation, and so on.
  class IndexResponder
    # Methods neither depending on nor affecting instance state
    module Internals
      def self.all_the_things
        Thing.all.sort_by(&:id)
      end
    end
    private_constant :Internals

    def initialize(controller)
      @controller = controller
      self
    end

    def call(_params = {}, &_block)
      @things = Internals.all_the_things
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
      controller.flash[:info] = flash_message
      self
    end
  end # class ThingsController::IndexResponder
end
