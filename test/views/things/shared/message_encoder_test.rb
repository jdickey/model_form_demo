
require 'test_helper'

describe 'Views::Things::Shared::MessageEncoder' do
  let(:described_class) { Views::Things::Shared::MessageEncoder }
  let(:simple_input_string) { 'A simple input string.' }
  let(:multiple_strings) do
    ['String 1', 'String 2', 'String 3']
  end

  describe 'has an .encode method that, when given input of' do
    let(:subject) { described_class.method :encode }

    # If you encode an already-encoded string, then you are On Your Own.
    describe 'a simple string, produces' do
      let(:output) { subject.call simple_input_string }

      it 'a string as output' do
        expect(output).must_respond_to :to_str
      end

      it 'JSON-encoded output' do
        expect { JSON.load output }.must_be_silent
      end

      it 'an encoded array (of strings)' do
        decoded = JSON.load output
        expect(decoded).must_respond_to :to_a
      end

      it 'an encoded single-element array' do
        decoded = JSON.load output
        expect(decoded.count).must_equal 1
      end

      it 'an encoding of the input string as the encoded array element' do
        decoded = JSON.load output
        expect(decoded.first).must_equal simple_input_string
      end
    end # describe 'a simple string, produces'

    describe 'an Array-like enumeration of strings, produces' do
      let(:output) { subject.call multiple_strings }

      it 'a string as output' do
        expect(output).must_respond_to :to_str
      end

      it 'JSON-encoded output' do
        expect { JSON.load output }.must_be_silent
      end

      it 'an encoded multi-element array of strings' do
        decoded = JSON.load output
        expect(decoded).must_respond_to :to_a
      end

      it 'an encoded array encoding each item in the input array' do
        decoded = JSON.load(output)
        expect(decoded).must_equal multiple_strings
      end
    end # describe 'an Array-like enumeration of strings, produces'
  end # describe 'has an .encode method that, when given input of'

  describe 'has a .decode method that, when given input of' do
    let(:subject) { described_class.method :decode }

    describe 'a simple string, produces' do
      let(:output) { subject.call simple_input_string }

      it 'an array as output' do
        expect(output).must_be_instance_of Array
      end

      it 'an array with a single element' do
        expect(output.count).must_equal 1
      end

      it 'an array containing the input string as its single element' do
        expect(output.first).must_equal simple_input_string
      end
    end # describe 'a simple string, produces'

    describe 'an encoded string, produces' do
      let(:input) { JSON.dump simple_input_string }
      let(:output) { subject.call input }

      it 'an array as output' do
        expect(output).must_be_instance_of Array
      end

      it 'an array with a single element' do
        expect(output.count).must_equal 1
      end

      it 'an array containing the decoded input string as its single element' do
        expect(output.first).must_equal simple_input_string
      end
    end # describe 'an encoded string, produces'

    describe 'an encoded array of strings, produces' do
      let(:input) { JSON.dump multiple_strings }
      let(:output) { subject.call input }

      it 'an array as output' do
        expect(output).must_be_instance_of Array
      end

      it 'an array with the correct number of elements' do
        expect(output.count).must_equal multiple_strings.count
      end

      it 'an array containing the decoded input strings as elements' do
        expect(output).must_equal multiple_strings
      end
    end # describe 'an encoded array of strings, produces'
  end # describe 'has a .decode method that, when given input of'
end # describe 'Views::Things::Shared::MessageEncoder'
