
require_relative 'things_controller/index_responder'

# ThingsController is our  one and only demo controller.
class ThingsController < ApplicationController
  include SemanticLogger::Loggable

  def index
    index_responder { |things| @things = things }
    self
  end

  private

  def index_responder
    IndexResponder.new(self).call(params) { |things| yield things }
  end
end
