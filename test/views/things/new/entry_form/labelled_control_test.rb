
require 'test_helper'

describe 'Views::Things::New::EntryForm::LabelledControl' do
  let(:described_class) { Views::Things::New::EntryForm::LabelledControl }
  let(:builder) do
    Class.new do
      attr_reader :label_calls

      def initialize(*params)
        super
        @label_calls = []
        self
      end

      def label(*params)
        Rails.logger.debug 'In fake builder #label method', params
        @label_calls.push params
      end
    end.new
  end
  let(:valid_subclass) do
    Class.new(described_class) do
      def control_field
        Rails.logger.debug 'In overridden #control_field method', assigns
      end
    end
  end
  let(:obj) { described_class.new builder: builder, field_id: :anything }

  describe 'when the #control_field method is' do
    it 'not overridden, the widget cannot be rendered' do
      expected = 'Must override LabelledControl#control_field.'
      error = expect { obj.to_html }.must_raise NotImplementedError
      expect(error.message).must_match expected
    end

    it 'overridden, the widget works as expected' do
      obj = valid_subclass.new builder: builder, field_id: :anything
      expect { obj.to_html }.must_be_silent
    end
  end # describe 'when the #control_field method is'
end # describe 'Views::Things::New::EntryForm::LabelledControl'