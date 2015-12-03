
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
    let(:initial_quantity) { rand(1..1_000_000) }
    let(:thing_description) { 'Absolutely indescribable.' }
    let(:thing_name) { 'Something Or Other' }

    before do
      fill_in 'Name', with: thing_name
      fill_in 'Initial quantity', with: initial_quantity
      fill_in 'Description', with: thing_description
    end

    it 'raises a RoutingError because the create action does not yet exist' do
      routing_error = ActionController::RoutingError
      error = expect { click_button 'Submit' }.must_raise routing_error
      expect(error.message).must_equal 'No route matches [POST] "/things/new"'
    end
  end # describe 'when given valid field data'
end # feature 'Landing Page'
