
# Class encapsulating all page-specific view code for `things/index`.
class Views::Things::Index < Views::Base
  needs :things

  def content
    title_content
    page_header
    table_widget
  end

  private

  # This method smells of :reek:TooManyStatements
  def header_row_widget
    captions = ['ID', 'Name', 'Initial Quantity', 'Description']

    tr do
      captions.each { |caption| th { text caption } }
    end
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
