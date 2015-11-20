
require 'test_helper'

describe 'ThingsController::IndexResponder' do
  let(:described_class) { ThingsController::IndexResponder }

  describe 'initialisation' do
    it 'requires one parameter' do
      error = expect { described_class.new }.must_raise ArgumentError
      expect(error.message).must_equal 'wrong number of arguments (0 for 1)'
    end
  end # describe 'initialisation'

  describe 'has a #call method that' do
    let(:dummy_controller) do
      Class.new do
        attr_reader :flash

        def initialize(*)
          @flash = {}
        end
      end.new
    end
    let(:obj) { described_class.new dummy_controller }

    describe 'can be called without parameters but' do
      it 'requires a block' do
        error = expect { obj.call }.must_raise LocalJumpError
        expect(error.message).must_equal 'no block given (yield)'
      end

      it 'yields an array-like enumerable to the block' do
        obj.call do |yielded|
          expect(yielded).must_respond_to :to_ary
        end
      end
    end # describe 'can be called without parameters but'

    it "assigns to the controller's success flash message" do
      obj.call { |_| }
      expected = 'There are currently no things in the system.'
      expect(dummy_controller.flash[:success]).must_equal expected
    end
  end # describe 'has a #call method that'
end # describe 'ThingsController::IndexResponder'
