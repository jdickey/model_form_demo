
# Class encapsulating all page-specific view code for `things/index`.
class Views::Things::Index < Views::Base
  needs :things, flash: {}

  def content
    widget Flashes, flashes: flash
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

  def non_detail_widgets
    messages = [:title_content, :page_header, :add_thing_button]
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
