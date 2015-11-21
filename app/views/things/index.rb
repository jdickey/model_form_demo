
# Class encapsulating all page-specific view code for `things/index`.
class Views::Things::Index < Views::Base
  needs :things

  def content
    title_content
    page_header
    table_widget do
      detail_lines
    end
  end

  private

  def detail_field_for(thing, field)
    # td { text thing.send(field) }
    td { detail_field_value_for thing, field }
  end

  def detail_field_value_for(thing, field)
    text thing.send(field)
  end

  def detail_line_for(thing)
    field_syms = [:id, :name, :initial_quantity, :description]

    tr do
      field_syms.each { |sym| detail_field_for thing, sym }
    end
  end

  def detail_lines
    things.each { |thing| detail_line_for thing }
  end

  def header_row_widget
    captions = ['ID', 'Name', 'Initial Quantity', 'Description']

    tr do
      captions.each { |caption| header_row_widget_item caption }
    end
  end

  def header_row_widget_item(caption)
    th { text caption }
  end

  def title_content
    content_for :title, 'Model Form Demo'
  end

  def page_header
    h1 'Index All the Things'
  end

  def table_widget
    table do
      header_row_widget
      yield if block_given?
    end
  end
end # class Views::Things::Index
