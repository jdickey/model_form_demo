
require 'test_helper'

feature 'Landing Page' do
  let(:page_title) { 'Model Form Demo' }
  let(:thing_count) { 20 }

  it 'has the correct content' do
    visit root_path
    # it displays the correct page title
    expect(page.title).must_equal page_title
    # it displays the correct page-content header
    expect(page).must_have_selector 'h1', text: 'Index All the Things'
    # it must have a header row as the first row of the table
    expect(page).must_have_selector 'table > tr:first-child > th:first-child',
                                    text: 'Id'
    # it displays the correct number of table rows
    expect(page).must_have_selector 'tr', count: thing_count + 1
    # it displays an 'Add New Thing' button
    expect(page).must_have_selector 'button.btn', text: 'Add New Thing'
  end

  it 'renders the correct markup when clicking the "Add New Thing" button' do
    # Why don't we just stick the next two lines in a `before` block? Because
    # Poltergeist (or `capybara_webkit` or `selenium`) are *bloody slow* when
    # compared to the default `rack_test` driver. Only enable a JS-aware driver
    # when your test is actually dependent on JavaScript or something compiled
    # to it.
    Capybara.current_driver = :poltergeist
    visit root_path
    page.find('button').click
    # Our current 'new' template doesn't specify any content, so...
    expected = '<html><head></head><body></body></html>'
    expect(page.body).must_equal expected
    Capybara.use_default_driver
  end
end # feature 'Landing Page'
