
# Class encapsulating all page-specific view code for `things/new`.
class Views::Things::New < Views::Base
  needs :thing, flash: {},
                title_content: 'Add New Thing to List of All Things'

  include SemanticLogger::Loggable

  def content
    logger.debug 'Entering #content', thing: thing, flash: flash
    page_title_content
  end

  private

  def page_title_content
    content_for :title, title_content
  end
end # class Views::Things::New
