
require 'test_helper'

require File.expand_path('app/form_objects/create_thing', Rails.root)

describe 'FormObjects::CreateThing' do
  let(:described_class) { FormObjects::CreateThing }
  let(:obj) { described_class.new params }
  let(:params) { FactoryGirl.attributes_for :thing }

  describe 'when initialised with valid attributes' do
    it 'initially corresponds to a new ORM instance' do
      expect(obj).must_be :new?
    end

    it 'is valid' do
      expect(obj).must_be :valid?
    end

    it 'can be saved' do
      expect { obj.save }.must_be_silent
      thing = Thing.find(name: obj.name)
      expect(thing).wont_be :nil?
      thing.destroy
    end
  end # describe 'when initialised with valid attributes'

  describe 'when initialised with invalid attributes' do
    let(:params) { FactoryGirl.attributes_for :thing, initial_quantity: 0 }

    it 'initially corresponds to a new ORM instance' do
      expect(obj).must_be :new?
    end

    it 'is invalid' do
      expect(obj).wont_be :valid?
    end

    it 'has the correct error message' do
      obj.valid?
      expected = ['Initial quantity must be greater than or equal to 1']
      expect(obj.errors.full_messages).must_equal expected
    end

    it 'cannot be saved' do
      expect { obj.save }.must_raise FormObjects::CreateThing::ValidationError
      expect(Thing.find name: obj.name).must_be :nil?
    end

    it 'raises an error with the correct message when attempting to save' do
      error = expect { obj.save }.must_raise RuntimeError
      expected = 'Validation of Thing attributes failed. Invalid attributes: ' \
        "#{params}, errors found: " \
        '["Initial quantity must be greater than or equal to 1"]'
      expect(error.message).must_equal expected
    end
  end # describe 'when initialised with invalid attributes'

  describe 'validation fails correctly when' do
    after do
      obj = described_class.new params
      obj.valid?
      expect(obj.errors.full_messages).must_equal @messages
    end

    describe 'the :name field is' do
      it 'missing' do
        params.delete :name
        @messages = ["Name can't be blank"]
      end

      it 'actually blank' do
        params[:name] = ' ' * 30
        @messages = ["Name can't be blank"]
      end

      it 'a duplicate' do
        described_class.new(params).save
        @messages = ['Name has already been added. Please enter a new one.']
      end
    end # describe 'the :name field is'

    describe 'the :initial_quantity field is' do
      it 'missing' do
        params.delete :initial_quantity
        @messages = ['Initial quantity is not a number']
      end

      it 'really not a number' do
        params[:initial_quantity] = 'oops'
        @messages = ['Initial quantity is not a number']
      end

      # A numeric, non-integer value is truncated by Virtus. Enter 3.14, get 3.

      it 'zero' do
        params[:initial_quantity] = 0
        @messages = ['Initial quantity must be greater than or equal to 1']
      end

      it 'negative' do
        params[:initial_quantity] = (-74)
        @messages = ['Initial quantity must be greater than or equal to 1']
      end
    end # describe 'the :initial_quantity field is'

    describe 'the :description field is' do
      it 'missing' do
        params.delete :description
        @messages = ["Description can't be blank"]
      end

      it 'actually blank' do
        params[:description] = ' ' * 30
        @messages = ["Description can't be blank"]
      end
    end # describe 'the :description field is'
  end # describe 'validation fails correctly when'
end # describe 'FormObjects::CreateThing'
