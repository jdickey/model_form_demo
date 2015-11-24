
require 'test_helper'

describe 'Views::Things::Index::TableWidget::ThingDetailLine' do
  let(:described_class) { Views::Things::Index::TableWidget::ThingDetailLine }

  it 'must be initialised with a :thing parameter' do
    expected = Fortitude::Errors::MissingNeed
    error = expect { described_class.new }.must_raise expected
    expect(error.message).must_match 'not supplied: thing'
  end

  describe 'has a #to_html method that renders' do
    let(:obj) { described_class.new thing: thing }
    let(:thing) { FactoryGirl.build_stubbed :thing }
    let(:actual) { obj.to_html }
    let(:nodes) { Ox.parse actual }

    it 'a containing :tr tag' do
      expect(nodes.name).must_equal 'tr'
    end

    describe 'a containing :tr tag that' do
      it 'has no CSS styling at all' do
        expect(nodes[:class]).must_be :nil?
        expect(nodes[:style]).must_be :nil?
      end

      it 'one child node/element per field' do
        expect(nodes.nodes.count).must_equal thing.columns.count
      end

      describe 'each child element' do
        it 'is a :td tag pair' do
          others = nodes.nodes.reject { |node| node.name == 'td' }
          expect(others).must_be :empty?
        end

        it 'has the correct column-detail text' do
          actual = nodes.nodes.map(&:text)
          expected = thing.columns.map { |column| thing[column].to_s }
          expect(actual).must_equal expected
        end
      end # describe 'each child element'
    end # describe 'a containing :tr tag that'
  end # describe 'has a #to_html method that renders'
end # describe 'Views::Things::Index::TableWidget::ThingDetailLine'
