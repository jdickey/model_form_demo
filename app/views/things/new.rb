
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  needs :thing, flash: {},
                title_content: 'Add New Thing to List of All Things'

  include SemanticLogger::Loggable
  include Views::Things::Shared

  def content
    flash_messages
    page_title_content
    container { form_row }
  end

  private

  def container
    div(class: 'container') { yield }
  end

  def flash_messages
    widget Flashes, flashes: flash
  end

  def form_row
    row { widget EntryForm, thing: thing }
  end

  def page_title_content
    content_for :title, title_content
  end

  def row
    div(class: 'row') { yield }
  end
end # class Views::Things::New
