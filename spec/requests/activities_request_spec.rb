require 'rails_helper'

RSpec.describe 'Activities', type: :request do
  before(:each) do
    icon_file = Rails.root.join('app', 'assets', 'images', 'icon-1.png')
    icon_blob = fixture_file_upload(icon_file, 'image/png')

    @user1 = User.create(name: 'Test user', email: 'test@gmail.com', password: '123456',
                         password_confirmation: '123456')
    @category1 = @user1.categories.create(name: 'Truth is fiction', icon: icon_blob, author: @user1)
    @category2 = @user1.categories.create(name: 'Lies is fiction', icon: icon_blob, author: @user1)
    @category3 = @user1.categories.create(name: 'Lorem ips is fiction', icon: icon_blob, author: @user1)
    @activity_one = Activity.create(author: @user1, category: @category1, category_id: @category1.id,
                                    name: 'I am comment 1', amount: 40)
    @activity_two = Activity.create(author: @user1, category: @category1, category_id: @category1.id,
                                    name: 'I am comment 2', amount: 40)
    @activity_three = Activity.create(author: @user1, category: @category1, category_id: @category1.id,
                                      name: 'I am comment 3', amount: 40)
    post user_session_path params: { user: { email: @user1.email, password: @user1.password } }
  end
  describe 'GET activities#index' do
    it 'returns http success' do
      get user_category_activities_path(@user1, @category1)
      expect(response).to have_http_status(200)
    end
    it 'renders the index template' do
      get user_category_activities_path(@user1, @category1)
      expect(response).to render_template('index')
    end
    it 'displays the activity name' do
      get user_category_activities_path(@user1, @category1)
      expect(response.body).to include(@category1.activities.first.name)
    end
  end

  describe 'GET activities#new' do
    it 'returns http success' do
      get new_user_category_activity_path(@user1, @category1)
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_category_activity_path(@user1, @category1)
      expect(response).to render_template('new')
    end
    it 'displays the new activity form' do
      get new_user_category_activity_path(@user1, @category1)
      expect(response.body).to include('ADD NEW TRANSACTION')
    end
  end
end
