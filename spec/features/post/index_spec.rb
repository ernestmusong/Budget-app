require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
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
    @comment_four = Comment.create(author: @user1, post: @post1, text: 'I am comment 4')
    @comment_five = Comment.create(author: @user1, post: @post1, text: 'I am comment 5')
    @comment_six = Comment.create(author: @user1, post: @post1, text: 'I am comment 6')
  end

  after :all do
    User.destroy_all
    Post.destroy_all
  end

  scenario "I can see the user's profile picture." do
    visit user_posts_path(@user1)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
  end

  scenario "I can see the user's username." do
    visit user_posts_path(@user1)
    expect(page).to have_content(@user1.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_posts_path(@user1)
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end

  scenario "I can see a post's title." do
    visit user_posts_path(@user1)
    expect(page).to have_content(@post1.title)
  end

  scenario "I can see some of the post's body" do
    visit user_posts_path(@user1)
    expect(page).to have_content(truncate(@post1.text, length: 20))
  end

  scenario 'I can see the first comments on a post' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@post1.recent_comments.first.text)
  end

  scenario 'I can see how many comments a post has.' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@post1.comments_counter)
  end

  scenario 'I can see how many likes a post has.' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@post1.likes_counter)
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user1)
    expect(page).to have_selector('#next')
    expect(page).to have_link('Add New Post', href: "/users/#{@user1.id}/posts/new")
  end

  scenario "When I click on a post, it redirects me to that post's show page" do
    visit user_posts_path(@user1)
    click_link @post1.title
    expect(current_path).to eq(user_post_path(@user1, @post1))
  end
end
