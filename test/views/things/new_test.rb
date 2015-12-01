
require 'test_helper'

require File.expand_path('app/views/things/new', Rails.root)

describe 'Views::Things::New' do
  let(:described_class) { Views::Things::New }
  let(:flash) { ActionDispatch::Flash::FlashHash.new }
  let(:thing) { FactoryGirl.build_stubbed :thing }
  let(:obj) do
    described_class.new(thing: thing, flash: flash).tap do |ret|
      ret.class_eval do
        attr_reader :cf_attrib, :cf_value

        def ret.content_for(attrib, value)
          @cf_attrib = attrib
          @cf_value = value
        end
      end
    end
  end
  let(:helpers_mock) do
    Class.new do
      # This method smells of :reek:UtilityFunction for API compatibility.
      def form_for(record, options = {}, &block)
        Rails.logger.debug 'In #form_for', record: record, options: options,
                                           block_source: block.source
      end
    end.new
  end
  let(:actual) do
    rc = Fortitude::RenderingContext.new(helpers_object: helpers_mock)
    obj.to_html rc
  end
  # let(:actual) { obj.to_html }

  it 'calls the #content_for helper correctly when rendered' do
    _ = actual # nothing happens until widget is rendered, so...
    expect(obj.cf_attrib).must_equal :title
    expect(obj.cf_value).must_equal 'Add New Thing to List of All Things'
  end
end # describe 'Views::Things::New'
