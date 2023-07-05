require 'rails_helper'

RSpec.describe 'users#index', type: :feature do
  before :all do
    @user1 = User.create(name: 'Musong',
                         photo: 'https://tse1', posts_counter: 3)
    @user2 = User.create(name: 'Ernest',
                         photo: 'https://tse1.mm', posts_counter: 0)
    @user3 = User.create(name: 'Akeh',
                         photo: 'https://tse1.m', posts_counter: 0)

    @post1 = @user1.posts.create(title: 'Truth is fiction', text: 'Lorem ipsum dolor sit amet', author: @user1)
    @post2 = @user1.posts.create(title: 'Lies is fiction', text: 'Lorem ipsum dolor sit amet', author: @user1)
    @post3 = @user1.posts.create(title: 'Lorem is fiction', text: 'Lorem ipsum dolor sit amet', author: @user1)
  end

  after :all do
    User.destroy_all
    Post.destroy_all
  end

  scenario 'I can see the username of all other users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@user3.name)
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_selector("img[src='#{@user2.photo}']")
    expect(page).to have_selector("img[src='#{@user3.photo}']")
  end

  scenario 'I can see the number of posts for each user' do
    visit users_path

    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user3.posts_counter}")
  end

  scenario "When I click on a user, I am redirected to that user's show page" do
    visit users_path
    within 'ul.users_list' do
      find('li.list_item', text: 'Musong').find('.link').click
      expect(current_path).to eq(user_path(User.find_by(name: 'Musong')))
    end
  end
end
