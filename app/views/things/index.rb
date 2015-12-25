
require File.expand_path 'app/views/things/shared/flashes', Rails.root

# Class encapsulating all page-specific view code for `things/index`.
class Views::Things::Index < Views::Base
  needs :things, flash: {}

  def content
    widget Views::Things::Shared::Flashes, flashes: flash
    non_detail_widgets
    detail_table
  end

  private

  def add_thing_button
    row_with_single_column { widget AddThingButton }
  end

  def detail_table
    row_with_single_column { table_widget { detail_lines } }
  end

  def non_detail_widgets
    messages = [:title_content, :page_header, :add_thing_button]
    messages.each { |message| send message }
  end

  def row_with_single_column
    styled_row { single_column { yield } }
  end

  def single_column
    div(class: 'col-md-12') { yield }
  end

  def styled_row
    div(class: 'row') { yield }
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
