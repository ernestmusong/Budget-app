require 'rails_helper'

RSpec.describe 'posts#show', type: :feature do
  before :all do
    @user1 = User.create(name: 'Musong', photo: 'https://tse1=Api&P=0&h=180', bio: 'A web developer', posts_counter: 6)
    @post1 = @user1.posts.create(title: 'Truth is fiction', text: 'Lorem ipsum do', author: @user1)
    @post2 = @user1.posts.create(title: 'Lies is fiction', text: 'Lorem rything sit amet', author: @user1)
    @post3 = @user1.posts.create(title: 'Lorem ips is fiction', text: 'Lorenthough dolor sit amet', author: @user1)
    @post4 = @user1.posts.create(title: 'Lorem ipsum fiction', text: 'Loruse sometimes sit amet', author: @user1)
    @post5 = @user1.posts.create(title: 'Lorem ipsum doro fiction', text: 'Lor not the dolor sit amet', author: @user1)
    @post6 = @user1.posts.create(title: 'Lorem ipsum ion', text: 'Lorem ipsum dolor sit amet', author: @user1)
    @comment_one = Comment.create(author: @user1, post: @post1, text: 'I am comment 1')
    @comment_two = Comment.create(author: @user1, post: @post1, text: 'I am comment 2')
    @comment_three = Comment.create(author: @user1, post: @post1, text: 'I am comment 3')
    @comment_four = Comment.create(author: @user1, post: @post2, text: 'I am comment 4')
    @comment_five = Comment.create(author: @user1, post: @post3, text: 'I am comment 5')
    @comment_six = Comment.create(author: @user1, post: @post4, text: 'I am comment 6')
  end

  after :all do
    User.destroy_all
    Post.destroy_all
  end

  scenario "I can see the post's title" do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.title)
  end

  scenario 'I can see who wrote the post.' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@user1.name)
  end

  scenario 'I can see how many comments it has' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.comments_counter)
  end

  scenario 'I can see how many likes it has.' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.likes_counter)
  end

  scenario 'I can see the post body' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@post1.text)
  end

  scenario 'I can see the username of each commentor' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@comment_one.author.name)
    expect(page).to have_content(@comment_two.author.name)
    expect(page).to have_content(@comment_three.author.name)
  end

  scenario 'I can see the comment each commentor left' do
    visit user_post_path(@user1, @post1)
    expect(page).to have_content(@comment_one.text)
    expect(page).to have_content(@comment_two.text)
    expect(page).to have_content(@comment_three.text)
  end
end
