
require 'test_helper'

require File.expand_path 'app/views/things/shared/flash_alert', Rails.root

describe 'Views::Things::Shared::FlashAlert' do
  let(:described_class) { Views::Things::Shared::FlashAlert }
  let(:actual) { obj.to_html.strip }
  let(:message_text) { 'A Message' }
  let(:nodes) { Ox.parse actual }
  let(:obj) { described_class.new type: @alert_class, message: message_text }

  describe 'requires parameters for' do
    let(:missing_need) { Fortitude::Errors::MissingNeed }

    after do
      missing = name.split(':').last
      error = expect { described_class.new @params }.must_raise missing_need
      expect(error.message).must_match "not supplied: #{missing}"
    end

    it ':message' do
      @params = { type: :success }
    end

    it ':type' do
      @params = { message: message_text }
    end
  end # describe 'requires parameters for'

  describe 'produces output from the #to_html method that' do
    describe 'for any alert class (or none at all)' do
      it 'is wrapped with a :div tag pair' do
        expect(nodes.name).must_equal 'div'
      end

      describe 'is wrapped with a :div tag pair that' do
        it 'has the CSS class "alert"' do
          expect(nodes[:class].split).must_equal %w(alert alert-dismissible)
        end

        it 'has two child elements' do
          expect(nodes.nodes.count).must_equal 2
        end

        it 'has a button.close for the first child element' do
          button = nodes.nodes.first
          expect(button.name).must_equal 'button'
          expect(button[:class].split).must_equal %w(close)
        end

        it 'has a :p element containing the text of the message' do
          para = nodes.nodes[1]
          expect(para.name).must_equal 'p'
          expect(para.text).must_equal message_text
        end
      end # describe 'is wrapped with a :div tag pair that'
    end # describe 'for any alert class (or none at all)'

    describe 'for an alert class of' do
      after do
        classes = %w(alert alert-dismissible) + Array(@expected.split)
        expect(nodes[:class].split).must_equal classes
      end

      it 'success' do
        @alert_class = :success
        @expected = 'alert-success'
      end

      it 'error' do
        @alert_class = :error
        @expected = 'alert-danger'
      end

      it 'alert' do
        @alert_class = :alert
        @expected = 'alert-warning'
      end

      it 'notice' do
        @alert_class = :notice
        @expected = 'alert-info'
      end

      it 'something else' do
        @alert_class = 'something else'
        @expected = 'something else'
      end

      it 'nothing at all' do
        @expected = ''
      end
    end # describe 'for an alert class of'
  end # describe 'produces output from the #to_html method that'
end
