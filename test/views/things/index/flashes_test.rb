
require 'test_helper'
require 'ox'

require 'support/be_named'
require 'support/have_css_classes'

require File.expand_path 'app/views/things/index/flashes', Rails.root

# This method smells of :reek:UtilityFunction (because it is one)
def alert_class(type)
  styles = {
    success:  'alert-success',
    error:    'alert-danger',
    alert:    'alert-warning',
    notice:   'alert-info'
  }
  type_sym = type.to_sym
  return styles[type_sym] if styles.key? type_sym
  type.to_s
end

def alert_classes(data, index)
  alert = alert_class(data[index].keys.first)
  %w(alert alert-dismissible) + [alert]
end

# FIXME: This needs to be made into one or more proper matchers.
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
# This method smells of :reek:DuplicateMethodCall, :reek:NestedIterators
# This method smells of :reek:TooManyStatements
def describe_flash_entries_for(case_env, outer_description_in, data_in)
  outer_description = outer_description_in
  data = data_in
  case_env.instance_eval do
    describe outer_description do
      before do
        data.each do |entry|
          flash_obj.send :[]=, entry.keys.first, entry.values.first
        end
      end

      it 'has the correct number of top-level elements' do
        expect(nodes.count).must_equal data.count
      end

      describe 'verifies that each top-level element' do
        it 'is a :div element' do
          nodes.each { |node| expect(node).must be_named 'div' }
        end

        it 'has the correct CSS classes' do
          nodes.each_with_index do |node, index|
            expect(node).must have_css_classes alert_classes(data, index)
          end
        end

        it 'has the correct content' do
          nodes.each_with_index do |node, index|
            content_node = node.locate('p').first
            expect(content_node.text).must_equal data[index].values.first
          end
        end
      end # describe 'verifies that each top-level element'
    end # describe outer_description
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

describe 'Views::Things::Index::Flashes' do
  let(:described_class) { Views::Things::Index::Flashes }
  let(:actual) { obj.to_html.strip }
  let(:flash_obj) { ActionDispatch::Flash::FlashHash.new }
  let(:obj) { described_class.new flashes: flash_obj }
  # NOTE: Remember that we're not rendering a *container* of FlashAlert widgets,
  #       but a *sequence*, and Ox doesn't play nicely with unbounded sequences
  #       -- so we have to 'fake' bounding by wrapping `actual` in a parent
  #       element, and then tell Ox to hand back that element's child nodes as
  #       `nodes`.
  let(:nodes) do
    bounded = ['<div>', '</div>'].join actual
    Ox.parse(bounded).nodes
  end

  it 'requires a :flashes parameter' do
    missing_need = Fortitude::Errors::MissingNeed
    error = expect { described_class.new }.must_raise missing_need
    expect(error.message).must_match 'not supplied: flashes'
  end

  describe 'produces output from its #to_html method' do
    describe 'for an empty message list' do
      it 'returns an empty string' do
        expect(actual).must_equal ''
      end
    end # describe 'for an empty message list'

    describe 'for a message list with' do
      describe_flash_entries_for self, 'one entry',
                                 [{ alert: 'This is an alert.' }]

      describe_flash_entries_for self, 'multiple entries',
                                 [{ alert: 'This is an alert.' },
                                  { error: 'This is an error.' }]
    end # describe 'for a message list with'
  end # describe 'produces output from its #to_html method'
end
