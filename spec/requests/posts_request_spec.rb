require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/:user_id/posts'
      expect(response).to be_successful
    end
    it 'renders correct template' do
      get '/users/:user_id/posts'
      expect(response).to render_template(:index)
    end
    it 'response body includes correct placeholder text' do
      get '/users/:user_id/posts'
      expect(response.body).to include('All posts with comments for a given user')
    end
  end
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }
    it 'returns http success' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end
    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end
    it 'response body includes correct placeholder text' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Post detail')
    end
  end
end
