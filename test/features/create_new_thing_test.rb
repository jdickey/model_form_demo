
require 'test_helper'

feature 'Create New Thing' do
  before do
    Capybara.current_driver = :poltergeist
    visit root_path
    page.find('button').click
  end

  after do
    Capybara.use_default_driver
  end

  it 'renders the correct markup when clicking the "Add New Thing" button' do
    # Our current 'new' template doesn't specify any content, so...
    expected = '<html><head></head><body></body></html>'
    expect(page.body).must_equal expected
  end
end # feature 'Landing Page'
