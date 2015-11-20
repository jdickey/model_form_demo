
require 'test_helper'

feature 'Landing Page' do
  before do
    visit root_path
  end

  it 'does not display the boilerplate Rails advert' do
    expect(page.title).must_equal 'ModelFormDemo'
  end
end # feature 'Landing Page'
