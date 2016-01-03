
require 'test_helper'

describe 'ThingsController::IndexResponder' do
  let(:described_class) { ThingsController::IndexResponder }

  describe 'initialisation' do
    it 'requires one parameter' do
      error = expect { described_class.new }.must_raise ArgumentError
      expect(error.message).must_match(/wrong number of arguments \(.*0.* 1\)/)
    end
  end # describe 'initialisation'

  describe 'has a #call method that' do
    let(:count) { 20 }
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

      describe 'yields a value to the block that' do
        before do
          obj.call { |yielded| @yielded = yielded }
        end

        it 'is array-like' do
          expect(@yielded).must_respond_to :to_ary
        end

        it 'has the expected number of entries' do
          expect(@yielded.count).must_equal count
        end

        it 'must be sorted by ID number' do
          expect(@yielded).must_equal @yielded.sort_by(&:id)
        end
      end # describe 'yields a value to the block that'
    end # describe 'can be called without parameters but'

    # Assumes database is seeded with 20 dummy records.
    it "assigns to the controller's success flash message" do
      obj.call { |_| }
      expected = "There are currently #{count} things in the system."
      expect(dummy_controller.flash[:notice]).must_equal expected
    end
  end # describe 'has a #call method that'
end # describe 'ThingsController::IndexResponder'
