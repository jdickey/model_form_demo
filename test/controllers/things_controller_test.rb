
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
  end # describe 'GET :index'
end # describe 'ThingsController'
