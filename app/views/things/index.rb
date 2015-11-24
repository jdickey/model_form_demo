
# Class encapsulating all page-specific view code for `things/index`.
class Views::Things::Index < Views::Base
  needs :things, flash: {}

  include SemanticLogger::Loggable

  def content
    title_content
    flash_content
    page_header
    table_widget { detail_lines }
  end

  private

  def each_flash
    flash_as_hash.each { |type, message| yield type, message }
  end

  def flash_as_hash
    flash.to_h.symbolize_keys
  end

  def flash_content
    each_flash do |type, message|
      widget FlashAlert, type: type, message: message
    end
  end

  def title_content
    content_for :title, 'Model Form Demo'
  end

  def page_header
    h1 'Index All the Things'
  end

  def table_widget
    widget TableWidget, things: things
  end
end # class Views::Things::Index
