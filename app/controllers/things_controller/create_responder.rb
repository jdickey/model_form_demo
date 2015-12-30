
require 'create_thing'

# ThingsController is our  one and only demo controller.
class ThingsController < ApplicationController
  # Encapsulates all logic involved in create action, successful or otherwise.
  class CreateResponder
    include SemanticLogger::Loggable

    def initialize(controller)
      @controller = controller
      self
    end

    def call(params, &_block)
      create_and_save_thing params
      yield @thing
      handle_result
    end

    private

    attr_reader :controller, :thing

    def create_thing(params)
      @thing = FormObjects::CreateThing.new params['thing']
      self
    end

    def create_and_save_thing(params)
      create_thing params
      @thing.save if @thing.valid?
      # Rails.logger.debug 'Error messages for @thing',
      #                    @thing.errors.full_messages
      self
    end

    def encode_errors_to_flash
      error_str = Views::Things::Shared::MessageEncoder.encode @thing.errors
      controller.flash[:error] = error_str
      self
    end

    def handle_result
      return handle_success if @thing.valid?
      handle_failure
    end

    def handle_failure
      # Controller's @thing should already be set by this point per yield
      encode_errors_to_flash
      controller.render 'new'
      self
    end

    def handle_success
      controller.redirect_to success_redirect_target, success_flash
    end

    def success_flash
      message = ['Added your new "', '" Thing!'].join thing.name
      { flash: { success: message } }
    end

    def success_redirect_target
      controller.root_path
    end
  end # class ThingsController::CreateResponder
end # class ThingsController
