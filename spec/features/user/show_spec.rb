require 'rails_helper'

RSpec.describe 'users#show', type: :feature do
  before :all do
    @user1 = User.create(name: 'Musong', photo: 'https://tse1=Api&P=0&h=180', bio: 'A web developer', posts_counter: 6)
    @post1 = @user1.posts.create(title: 'Truth is fiction', text: 'Lorem ipsum do', author: @user1)
    @post2 = @user1.posts.create(title: 'Lies is fiction', text: 'Lorem rything sit amet', author: @user1)
    @post3 = @user1.posts.create(title: 'Lorem ips is fiction', text: 'Lorenthough dolor sit amet', author: @user1)
    @post4 = @user1.posts.create(title: 'Lorem ipsum fiction', text: 'Loruse sometimes sit amet', author: @user1)
    @post5 = @user1.posts.create(title: 'Lorem ipsum doro fiction', text: 'Lor not the dolor sit amet', author: @user1)
    @post6 = @user1.posts.create(title: 'Lorem ipsum ion', text: 'Lorem ipsum dolor sit amet', author: @user1)
  end

  after :all do
    User.destroy_all
    Post.destroy_all
  end

  scenario "I can see the user's profile picture." do
    visit user_path(@user1)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
  end

  scenario "I can see the user's username." do
    visit user_path(@user1)
    expect(page).to have_content(@user1.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(@user1)
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(@user1)
    expect(page).to have_content(@user1.bio)
  end

  scenario "I can see the user's first 3 posts." do
    visit user_path(@user1)
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.text)
    expect(page).to have_content(@post3.text)
    expect(page).not_to have_content(@post4.text)
  end

  scenario "When I click a user's post, it redirects me to that post's show page." do
    visit user_path(@user1)
    click_link @post1.text
    expect(current_path).to eq(user_post_path(@user1, @post1))
  end

  scenario "I can see a button that lets me view all of a user's posts." do
    visit user_path(@user1)
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(@user1))
  end
end
