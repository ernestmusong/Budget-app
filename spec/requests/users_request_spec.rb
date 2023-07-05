require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/'
      expect(response).to be_successful
    end
    it 'renders correct template' do
      get '/users/'
      expect(response).to render_template(:index)
    end
    it 'response body includes correct placeholder text' do
      get '/users/'
      expect(response.body).to include('Here is a list of all users')
    end
  end
  describe 'GET #show' do
    let(:user) { create(:user) }
    it 'returns http success' do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end
    it 'renders the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end
    it 'response body includes correct placeholder text' do
      get "/users/#{user.id}"
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
end
