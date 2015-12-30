
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

  describe 'POST :create' do
    before do
      @last = Thing.last
      post :create, params
    end

    after do
      Thing.find_all { |record| record.id > @last.id }.each(&:delete)
    end

    describe 'with valid field values' do
      let(:params) { { thing: FactoryGirl.attributes_for(:thing) } }

      it 'saves the record' do
        expect(Thing.find name: params[:thing][:name]).wont_be :nil?
      end

      it 'redirects to the root URL' do
        must_redirect_to root_url
      end

      it 'has the correct flash message' do
        expected = ['Added your new "', '" Thing!'].join params[:thing][:name]
        expect(flash[:success]).must_equal expected
      end

      it 'assigns the saved form object to the :thing assignment variable' do
        expect(assigns[:thing]).must_be_instance_of FormObjects::CreateThing
        expect(assigns[:thing].attributes).must_equal params[:thing]
      end
    end # describe 'with valid field values'

    describe 'with invalid field values' do
      let(:params) { FactoryGirl.attributes_for :thing, initial_quantity: 0 }

      it 'does not save the record' do
        expect(Thing.find name: params[:name]).must_be :nil?
      end

      it 're-renders the "new" template' do
        must_render_template 'new'
      end

      describe 'assigns to the :thing variable' do
        let(:thing) { assigns[:thing] }

        it 'a form-object instance' do
          expect(thing).must_be_instance_of FormObjects::CreateThing
        end

        it 'an unsaved instance' do
          expect(thing).must_be :new?
        end

        it 'an invalid instance' do
          expect(thing).wont_be :valid?
        end

        # Now that validation is properly hooked in, it complains bitterly.
        it 'sets correct encoded error-flash message for failed validation' do
          expected = ["Name can't be blank", 'Initial quantity is not a number',
                      "Description can't be blank"]
          expect(flash[:error]).must_equal JSON.dump(expected)
        end
      end # describe 'assigns to the :thing variable'
    end # describe 'with invalid field values'
  end # describe 'POST :create'
end # describe 'ThingsController'
