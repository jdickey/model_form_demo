
require 'test_helper'

require File.expand_path('app/views/things/index', Rails.root)

describe 'Views::Things::Index' do
  let(:described_class) { Views::Things::Index }
  let(:flash) { ActionDispatch::Flash::FlashHash.new }
  let(:things) { FactoryGirl.build_stubbed_list :thing, 20 }
  let(:obj) do
    described_class.new(things: things, flash: flash).tap do |ret|
      ret.class_eval do
        attr_reader :cf_attrib, :cf_value

        def ret.content_for(attrib, value)
          @cf_attrib = attrib
          @cf_value = value
        end
      end
    end
  end
  let(:actual) { obj.to_html }

  it 'calls the #content_for helper correctly when rendered' do
    _ = actual # nothing happens until widget is rendered, so...
    expect(obj.cf_attrib).must_equal :title
    expect(obj.cf_value).must_equal 'Model Form Demo'
  end

  describe 'properly renders' do
    let(:dummy) { ['<div>', '</div>'].join actual }
    let(:nodes) { Ox.parse(dummy).nodes }

    it 'the page header as the first child element' do
      expect(nodes.first.name).must_equal 'h1'
      expect(nodes.first.text).must_equal 'Index All the Things'
    end

    describe 'flash content' do
      let(:found) { nodes.select { |node| node.name == 'div' } }
      let(:info_text) { 'I have some information for you. That is all.' }

      describe 'when no flash messages are defined' do
        it 'has no top-level :div element' do
          expect(found).must_be :empty?
        end
      end # describe 'when no flash messages are defined'

      describe 'when one flash message is defined, it has' do
        before do
          flash[:notice] = info_text
        end

        it 'a top-level :div element' do
          expect(found).wont_be :empty?
        end

        describe 'a top-level :div element whose last child node has' do
          let(:alert_div) { found.first }
          let(:alert_text) { alert_div.nodes.last.text }

          it 'correct CSS styles' do
            expected = %w(alert alert-dismissible alert-info)
            expect(alert_div[:class].split.sort).must_equal expected
          end

          it 'correct text' do
            expect(alert_text).must_equal info_text
          end
        end # describe 'a top-level :div element whose last child node has'
      end # describe 'when one flash message is defined, it has'

      describe 'when two flash messages are defined, they' do
        let(:success_text) { 'You have succeeded at some action, sometime.' }

        before do
          flash[:notice] = info_text
          flash[:success] = success_text
        end

        it 'produce two top-level :div elements' do
          expect(found.count).must_equal 2
        end

        it 'alert :div elements in the expected order' do
          expect(found.first[:class].split).must_include 'alert-info'
          expect(found[1][:class].split).must_include 'alert-success'
        end
      end # describe 'when two flash messages are defined, they'
    end # describe 'flash content'

    it 'a table as the last child element' do
      expect(nodes.last.name).must_equal 'table'
    end

    describe 'a table as the last child element that' do
      let(:table) { nodes.last }

      it 'has as its first child element a :tr element' do
        expect(table.nodes.first.name).must_equal 'tr'
      end

      it 'has the correct number of child elements (rows)' do
        expect(table.nodes.count).must_equal things.count + 1
        table.nodes.each { |node| expect(node.name).must_equal 'tr' }
      end

      describe 'has in its first row' do
        let(:first_row) { table.nodes.first }

        it 'four :th child elements' do
          expect(first_row.nodes.count).must_equal 4
          first_row.nodes.each { |node| expect(node.name).must_equal 'th' }
        end

        describe 'a header for a column titled' do
          after do
            expect(@node.text).must_equal @expected
          end

          it '"ID" as the first column' do
            @node = first_row.nodes.first
            @expected = 'Id'
          end

          it '"Name" as the second column' do
            @node = first_row.nodes[1]
            @expected = 'Name'
          end

          it '"Initial Quantity" as the third column' do
            @node = first_row.nodes[2]
            @expected = 'Initial Quantity'
          end

          it '"Description" as the last column' do
            @node = first_row.nodes.last
            @expected = 'Description'
          end
        end # describe 'a header for a column titled'
      end # describe 'has in its first row'

      describe 'has a detail row for each thing which includes its' do
        after do
          thing_values = things.map { |thing| thing.send @thing_sym }
          rendered_values = table.nodes[1..-1].map do |row|
            row.nodes[@node_index].text.send(@node_sym)
          end
          expect(thing_values).must_equal rendered_values
        end

        it 'ID' do
          @thing_sym = :id
          @node_index = 0
          @node_sym = :to_i
        end

        it 'name' do
          @thing_sym = :name
          @node_index = 1
          @node_sym = :to_s
        end

        it 'initial quantity' do
          @thing_sym = :initial_quantity
          @node_index = 2
          @node_sym = :to_i
        end

        it 'description' do
          @thing_sym = :description
          @node_index = 3
          @node_sym = :to_s
        end
      end # describe 'has a detail row for each thing which includes its'
    end # describe 'a table as the last child element that'
  end # describe 'properly renders'
end # describe 'Views::Things::Index'
