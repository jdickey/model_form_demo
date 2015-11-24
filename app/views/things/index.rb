
# Class encapsulating all page-specific view code for `things/index`.
class Views::Things::Index < Views::Base
  needs :things, flash: {}

  def content
    non_detail_widgets
    detail_table
  end

  private

  def add_thing_button
    widget AddThingButton
  end

  def detail_table
    table_widget { detail_lines }
  end

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

  def non_detail_widgets
    messages = [:title_content, :flash_content, :page_header, :add_thing_button]
    messages.each { |message| send message }
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
