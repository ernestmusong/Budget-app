require 'rails_helper'

RSpec.describe 'activities#index', type: :feature do
  before(:each) do
    icon_file = Rails.root.join('app', 'assets', 'images', 'icon-1.png')
    icon_blob = fixture_file_upload(icon_file, 'image/png')
    @user1 = User.create(name: 'Test user', email: 'test@gmail.com', password: '123456',
                         password_confirmation: '123456')
    @category1 = Category.create(name: 'Truth is fiction', icon: icon_blob, author: @user1)
    @category2 = Category.create(name: 'Lies is fiction', icon: icon_blob, author: @user1)
    @category3 = Category.create(name: 'Lorem ips is fiction', icon: icon_blob, author: @user1)
    @activity_one = Activity.create(author: @user1, category: @category1, category_id: @category1.id,
                                    name: 'I am comment 1', amount: 40)
    @activity_two = Activity.create(author: @user1, category: @category1, category_id: @category1.id,
                                    name: 'I am comment 2', amount: 40)
    @activity_three = Activity.create(author: @user1, category: @category1, category_id: @category1.id,
                                      name: 'I am comment 3', amount: 40)
    visit new_user_session_path
    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Log in'
  end

  scenario 'I can see the names of the acitivities for the category1' do
    visit user_category_activities_path(@user1, @category1)
    @category1.activities.each do |a|
      expect(page).to have_content(a.name)
    end
  end
  scenario 'I can see the amount of each acitivity for the category1' do
    visit user_category_activities_path(@user1, @category1)
    @category1.activities.each do |a|
      expect(page).to have_content(a.amount)
    end
  end

  scenario 'I can see the sum of amounts for all activities in the category' do
    visit user_category_activities_path(@user1, @category1)
    expected_sum = @category1.activities.sum(&:amount)
    expect(page).to have_content(expected_sum)
  end

  scenario 'The number of activities should be 3' do
    visit user_category_activities_path(@user1, @category1)
    expect(@category1.activities.count).to eq(3)
  end

  scenario 'should have a button to add new activity' do
    visit user_category_activities_path(@user1, @category1)
    expect(page).to have_link('Add new transaction')
  end
end
