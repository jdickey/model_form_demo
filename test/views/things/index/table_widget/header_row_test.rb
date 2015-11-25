
require 'test_helper'

describe 'Views::Things::Index::TableWidget::HeaderRow' do
  let(:described_class) { Views::Things::Index::TableWidget::HeaderRow }

  it 'requires a :fields parameter' do
    expected = Fortitude::Errors::MissingNeed
    error = expect { described_class.new }.must_raise expected
    expect(error.message).must_match 'not supplied: fields'
  end

  describe 'when initialised with an array of symbols for field specs, it' do
    let(:actual) { obj.to_html }
    let(:dummy_div) { ['<div>', '</div>'].join(actual) }
    let(:dummy_nodes) { Ox.parse dummy_div }
    let(:fields) { [:id, :name, :some_longer_title] }
    let(:nodes) { dummy_nodes.nodes }
    let(:obj) { described_class.new fields: fields }

    before do
      _ = actual
    end

    it 'contains a single outermost tag pair' do
      expect(nodes.count).must_equal 1
    end

    it 'renders a containing :tr tag pair' do
      expect(nodes.first.name).must_equal 'tr'
    end

    describe 'renders a containing :tr tag pair containing' do
      let(:header_row) { nodes.first }

      it 'one child node/element per field' do
        expect(header_row.nodes.count).must_equal fields.count
      end

      describe 'each child element' do
        it 'is a :th tag pair' do
          others = header_row.nodes.reject { |node| node.name == 'th' }
          expect(others).must_be :empty?
        end

        it 'has the correct column-header text' do
          expected = fields.map { |s| s.to_s.humanize.titlecase }
          actual = header_row.nodes.map(&:text)
          expect(actual).must_equal expected
        end
      end # describe 'each child element'
    end # describe 'renders a containing :tr tag pair containing'
  end # describe 'when initialised ... array of symbols for field specs, it'
end # describe 'Views::Things::Index::TableWidget::HeaderRow'
