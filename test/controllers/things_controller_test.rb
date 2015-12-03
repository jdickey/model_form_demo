
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

  describe 'GET :new' do
    let(:seeded_records) { 20 }

    before do
      get :new
    end

    it 'responds with HTTP :OK (200)' do
      expect(response).must_be :ok?
    end

    it 'renders the "things/new" template' do
      must_render_template 'things/new'
    end

    it 'assigns a new Thing to the :thing variable' do
      thing = assigns[:thing]
      expect(thing).must_be_instance_of Thing
      expect(thing).must_be :new?
    end
  end # describe 'GET :new'
end # describe 'ThingsController'
