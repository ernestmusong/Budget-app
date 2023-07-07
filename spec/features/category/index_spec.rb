require 'rails_helper'

RSpec.describe 'categories#index', type: :feature do
  before(:each) do
    icon_file = Rails.root.join('app', 'assets', 'images', 'icon-1.png')
    icon_blob = fixture_file_upload(icon_file, 'image/png')
    @user1 = User.create(name: 'Test user', email: 'test@gmail.com', password: '123456',
                         password_confirmation: '123456')
    @category1 = @user1.categories.create(name: 'Truth is fiction', icon: icon_blob, author: @user1)
    @category2 = @user1.categories.create(name: 'Lies is fiction', icon: icon_blob, author: @user1)
    @category3 = @user1.categories.create(name: 'Lorem ips is fiction', icon: icon_blob, author: @user1)
    @activity_one = Activity.create(author: @user1, category_id: @category1.id, name: 'I am comment 1', amount: 40)
    @activity_two = Activity.create(author: @user1, category_id: @category1.id, name: 'I am comment 2', amount: 40)
    @activity_three = Activity.create(author: @user1, category_id: @category1.id, name: 'I am comment 3', amount: 40)
    visit new_user_session_path
    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Log in'
  end

  after :all do
    User.destroy_all
    Category.destroy_all
    Activity.destroy_all
  end
  scenario 'I can see three categories for the user' do
    visit user_categories_path(@user1)
    @user1.categories.each do |category|
      expect(page).to have_content(category.name)
    end
  end

  scenario 'I can see the sum of amounts for all activities in each category' do
    visit user_categories_path(@user1)
    @user1.categories.each do |category|
      expected_sum = category.activities.sum(&:amount)
      expect(page).to have_content(expected_sum)
    end
  end

  scenario 'The number of categories should be 3' do
    visit user_categories_path(@user1)
    expect(@user1.categories.count).to eq(3)
  end

  scenario 'should have a button to add category' do
    visit user_categories_path(@user1)
    expect(page).to have_link('Add new category')
  end
  scenario "When I click on a category, it redirects me to that category's detail page" do
    visit user_categories_path(@user1)
    click_link @category1.name
    expect(current_path).to eq(user_category_activities_path(@user1, @category1))
  end
end
