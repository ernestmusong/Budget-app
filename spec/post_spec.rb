require 'rails_helper'

RSpec.describe Post, type: :model do
  before :all do
    @first_user = User.create(name: 'Musong', photo: '', bio: 'A web developer')
    @first_post = Post.create(title: 'Truth is fiction', text: 'Lorem ipsum dolor sit amet', author: @first_user)
    @comment_one = Comment.create(author: @first_user, post: @first_post, text: 'I am comment 1')
    @comment_two = Comment.create(author: @first_user, post: @first_post, text: 'I am comment 2')
    @comment_three = Comment.create(author: @first_user, post: @first_post, text: 'I am comment 3')
    @comment_four = Comment.create(author: @first_user, post: @first_post, text: 'I am comment 4')
    @comment_five = Comment.create(author: @first_user, post: @first_post, text: 'I am comment 5')
    @comment_six = Comment.create(author: @first_user, post: @first_post, text: 'I am comment 6')
    @like_one = Like.create(author: @first_user, post: @first_post)
    @like_two = Like.create(author: @first_user, post: @first_post)
    @like_three = Like.create(author: @first_user, post: @first_post)
    @like_four = Like.create(author: @first_user, post: @first_post)
    @like_five = Like.create(author: @first_user, post: @first_post)
    @like_six = Like.create(author: @first_user, post: @first_post)
  end

  after :all do
    User.destroy_all
    Comment.destroy_all
    Like.destroy_all
    Post.destroy_all
  end

  describe '#Comments' do
    it 'should increment comments counter when comment is created ' do
      expect(@first_post.comments.count).to eq(6)
    end

    it 'should return recent 5 comments' do
      expect(@first_post.recent_comments).to eq(@first_post.comments[1..6])
    end
  end

  it 'should decrement comment counter when coment is destroyed' do
    @comment_one.destroy
    expect(@first_post.comments.count).to eq(5)
  end

  describe '#Like' do
    it 'should increment likes counter when like is created' do
      expect(@first_post.likes.count).to eq(6)
    end

    it 'should decremet likes counter when like is destroyed' do
      @like_one.destroy
      expect(@first_post.likes.count).to eq(5)
    end
  end

  describe '#Validations' do
    it 'Post title  must not be nil' do
      @first_post.title = nil
      expect(@first_post).not_to be_valid
    end

    it 'Post title is less than 250' do
      @first_post.title = 'abcde' * 51
      expect(@first_post).not_to be_valid
    end

    it 'Comments counter must not be nil' do
      @first_post.comments_counter = nil
      expect(@first_post).not_to be_valid
    end

    it 'likes counter must not be nill' do
      @first_post.likes_counter = nil
      expect(@first_post).not_to be_valid
    end

    it 'Comments counter must be greater than or equal to 0' do
      @first_post.comments_counter = -5
      expect(@first_post).not_to be_valid
    end

    it 'likes counter must be greater than or equal to 0' do
      @first_post.likes_counter = -5
      expect(@first_post).not_to be_valid
    end
  end
end
