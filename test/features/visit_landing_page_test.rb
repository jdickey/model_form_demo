
require 'test_helper'

feature 'Landing Page' do
  let(:thing_count) { 20 }

  before do
    visit root_path
  end

  it 'does not display the boilerplate Rails advert' do
    expect(page.title).must_equal 'Model Form Demo'
  end

  it 'displays the correct page title' do
    expect(page.title).must_equal 'Model Form Demo'
  end

  it 'displays the correct page-content header' do
    expect(page).must_have_selector 'h1', text: 'Index All the Things'
  end

  it 'must have a header row as the first row of the table' do
    expect(page).must_have_selector 'table > tr:first-child > th:first-child',
                                    text: 'ID'
  end

  it 'displays the correct number of table rows' do
    expect(page).must_have_selector 'tr', count: thing_count + 1
  end
end # feature 'Landing Page'
