
require 'test_helper'

describe 'ThingsController::NewResponder' do
  let(:described_class) { ThingsController::NewResponder }

  describe 'initialisation' do
    it 'requires one parameter' do
      error = expect { described_class.new }.must_raise ArgumentError
      expect(error.message).must_equal 'wrong number of arguments (0 for 1)'
    end
  end # describe 'initialisation'

  describe 'has a #call method that' do
    let(:obj) { described_class.new :anything_at_present }

    describe 'can be called without parameters but' do
      it 'requires a block' do
        error = expect { obj.call }.must_raise LocalJumpError
        expect(error.message).must_equal 'no block given (yield)'
      end
    end # describe 'can be called without parameters but'

    describe 'passes to the yielded-to block' do
      before do
        @args = nil
        obj.call { |*args| @args = args }
      end

      it 'one parameter' do
        expect(@args.count).must_equal 1
      end

      it 'a new Thing instance' do
        thing = @args.first
        expect(thing).must_be_instance_of Thing
        expect(thing).must_be :new?
      end
    end # describe 'passes to the yielded-to block'
  end # describe 'has a #call method that'
end # describe 'ThingsController::NewResponder'
