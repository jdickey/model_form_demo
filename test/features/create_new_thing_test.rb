
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

  describe 'when given valid field data' do
    let(:initial_quantity) { rand(1..100) }
    let(:thing_description) { 'Absolutely indescribable.' }
    let(:thing_name) { 'Something Or Other' }

    before do
      fill_in 'Name', with: thing_name
      fill_in 'Initial quantity', with: initial_quantity
      fill_in 'Description', with: thing_description
      click_button 'Submit'
    end

    after do
      Thing.find(name: thing_name).destroy
    end

    describe 'it reports success by adding a table row that' do
      let(:last_row) { page.find 'table > tr:last-child' }

      describe 'has the correct column values for' do
        after do
          td = last_row.find @selector
          expect(td.text).must_equal @expected.to_s
        end

        it 'ID' do
          @selector = 'td:first-child'
          @expected = Thing.last.id
        end

        it 'name' do
          @selector = 'td:nth-child(2)'
          @expected = thing_name
        end

        it 'initial quantity' do
          @selector = 'td:nth-child(3)'
          @expected = initial_quantity
        end

        it 'description' do
          @selector = 'td:nth-child(4)'
          @expected = thing_description
        end
      end # describe 'has the correct column values for'
    end # describe 'it reports success by adding a table row that'
  end # describe 'when given valid field data'
end # feature 'Landing Page'
