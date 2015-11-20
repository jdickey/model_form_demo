
# Base class for all controllers in the application, Including additional code
# shared between all controllers that is not part of `ActionController::Base`.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
