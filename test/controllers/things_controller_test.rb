
require 'test_helper'

describe 'ThingsController' do
  let(:described_class) { ThingsController }

  describe 'GET :index' do
    before do
      get :index
    end

    it 'responds with HTTP :OK (200)' do
      expect(response).must_be :ok?
    end

    it 'renders the "things/index" template' do
      must_render_template 'things/index'
    end

    it 'assigns an array of Things to the :things variable' do
      things = assigns[:things]
      expect(things).must_be_instance_of Array
      things.each { |thing| expect(thing).must_be_instance_of Thing }
    end
  end # describe 'GET :index'
end # describe 'ThingsController'
