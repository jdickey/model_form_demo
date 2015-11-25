
require 'test_helper'

feature 'Create New Thing' do
  before do
    visit new_thing_path
  end

  describe 'has the correct markup for the entry form, including' do
    it 'the correct title' do
      expect(page.title).must_equal 'Add New Thing to List of All Things'
    end
  end # describe 'has the correct markup for the entry form, including'
end # feature 'Landing Page'
