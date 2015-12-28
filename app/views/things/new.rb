
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  needs :thing, flash: {},
                title_content: 'Add New Thing to List of All Things'

  include SemanticLogger::Loggable

  def content
    flash_messages
    page_title_content
    form_widget
  end

  private

  def flash_messages
    Rails.logger.debug 'Flashes', flash: flash.to_h
    widget Views::Things::Shared::Flashes, flashes: flash
  end

  def form_widget
    widget EntryForm, thing: thing
  end

  def page_title_content
    content_for :title, title_content
  end
end # class Views::Things::New
