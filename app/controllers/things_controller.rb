
require_relative 'things_controller/index_responder'

# ThingsController is our  one and only demo controller.
class ThingsController < ApplicationController
  # include SemanticLogger::Loggable

  def index
    respond_with(IndexResponder) { |things| @things = things }
  end

  def new
    respond_with(NewResponder) { |thing| @thing = thing }
  end

  def create
    respond_with(CreateResponder) { |thing| @thing = thing }
  end

  private

  def respond_with(responder, &_block)
    responder.new(self).call(params) { |product| yield product }
  end
end
