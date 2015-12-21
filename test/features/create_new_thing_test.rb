
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

  describe 'when given field data that are' do
    let(:valid_description) { 'Absolutely indescribable.' }
    let(:valid_name) { 'Something Or Other' }
    let(:valid_quantity) { rand(1..100) }

    before do
      fill_in 'Name', with: thing_name
      fill_in 'Initial quantity', with: initial_quantity
      fill_in 'Description', with: thing_description
      click_button 'Submit'
    end

    describe 'valid' do
      let(:initial_quantity) { valid_quantity }
      let(:thing_description) { valid_description }
      let(:thing_name) { valid_name }

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
    end # describe 'valid'

    describe 'invalid due to an invalid value for' do
      describe 'initial quantity' do
        let(:initial_quantity) { 0 }
        let(:thing_description) { valid_description }
        let(:thing_name) { valid_name }

        it 'redisplays the new-thing form' do
          expect(page).must_have_selector 'form'
        end

        describe 'wraps div.field_with_errors elements around the' do
          let(:error_divs) { page.find_all('div.field_with_errors') }
          let(:label_container) { error_divs.first }
          let(:input_container) { error_divs.last }

          it 'label for the invalid field' do
            expect(label_container).must_have_selector 'label.control-class',
                                                       text: 'Initial quantity'
          end

          describe 'input control for the invalid field with the correct' do
            it 'input type' do
              expect(input_container).must_have_selector 'input[@type="number"]'
            end

            it 'name' do
              selector = 'input[@name="thing[initial_quantity]"]'
              expect(input_container).must_have_selector selector
            end
          end # describe 'input control for the invalid field with the correct'
        end # describe 'wraps div.field_with_errors elements around the'
      end # describe 'initial quantity'
    end # describe 'invalid due to an invalid value for'
  end # describe 'when given field data that are'
end # feature 'Create New Thing'
