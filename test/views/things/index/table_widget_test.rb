
require 'test_helper'

describe 'Views::Things::Index::TableWidget' do
  let(:described_class) { Views::Things::Index::TableWidget }

  it 'requires a :things parameter' do
    expected = Fortitude::Errors::MissingNeed
    error = expect { described_class.new }.must_raise expected
    expect(error.message).must_match 'not supplied: things'
  end

  describe 'produces output from its #to_html method that' do
    let(:actual) { obj.to_html }
    let(:list_size) { 20 }
    let(:nodes) { Ox.parse actual }
    let(:obj) { described_class.new things: things }
    let(:things) { FactoryGirl.build_stubbed_list :thing, list_size }

    it 'renders an outermost :table element' do
      expect(nodes.name).must_equal 'table'
    end

    describe 'renders an outermost :table element that' do
      it 'has Bootstrap table CSS styling' do
        expect(nodes[:class].split).must_equal %w(table table-hover)
      end

      it 'contains a :tr element as its first child, containing :th tags' do
        row_node = nodes.nodes.first
        expect(row_node.name).must_equal 'tr'
        others = row_node.nodes.reject { |n| n.name == 'th' }
        expect(others).must_be :empty?
      end
    end # describe 'renders an outermost :table element that'
  end # describe 'produces output from its #to_html method that'
end # describe 'Views::Things::Index::TableWidget'
