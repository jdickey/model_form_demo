
require 'test_helper'

describe 'ThingsController::IndexResponder::FlashMessageText' do
  let(:described_class) { ThingsController::IndexResponder::FlashMessageText }

  it 'requires one parameter' do
    error = expect { described_class.new }.must_raise ArgumentError
    expect(error.message).must_equal 'missing keyword: count'
  end

  describe 'when the specified count is' do
    let(:obj) { described_class.new count: count }

    describe 'zero' do
      let(:count) { 0 }
      let(:expected) { 'There are currently no things in the system.' }

      it 'returns the correct message from its #to_s method' do
        expect(obj.to_s).must_equal expected
      end

      it 'produces the correct message when treated as a string' do
        expect(obj.to_s).must_equal expected
      end
    end # describe 'zero'

    describe 'one' do
      let(:count) { 1 }
      let(:expected) { 'There is currently 1 thing in the system.' }

      it 'returns the correct message from its #to_s method' do
        expect(obj.to_s).must_equal expected
      end

      it 'produces the correct message when treated as a string' do
        expect(obj.to_s).must_equal expected
      end
    end # describe 'one'

    describe 'more than one' do
      let(:count) { 14_287 }
      let(:expected) { "There are currently #{count} things in the system." }

      it 'returns the correct message from its #to_s method' do
        expect(obj.to_s).must_equal expected
      end

      it 'produces the correct message when treated as a string' do
        expect(obj.to_s).must_equal expected
      end
    end # describe 'more than one'
  end # describe 'when the specified count is'
end # describe 'ThingsController::IndexResponder::FlashMessageText'
