
require 'test_helper'

feature 'Landing Page' do
  let(:page_title) { 'Model Form Demo' }
  let(:thing_count) { 20 }

  before do
    visit root_path
  end

  it 'has the correct content' do
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

  it 'performs the expected action when clicking the "Add New Thing" button' do
    # We've not yet defined the view for the action that our JS redirects us to.
    skip 'Our Script files do not seem to be active; clicking does nothing.'
    expected = ActionView::MissingTemplate
    error = expect { click_button 'Add New Thing' }.must_raise expected
    expect(error.message).must_match 'Missing template things/new'
  end
end # feature 'Landing Page'
