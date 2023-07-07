require 'rails_helper'

RSpec.describe Activity, type: :model do
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
  end

  describe '#Validations' do
    it 'Activity name  must not be nil' do
      @activity_one.name = nil
      expect(@activity_one).not_to be_valid
    end

    it 'Activity amount must be greater than 0 ' do
      @activity_one.amount = 0
      expect(@activity_one).not_to be_valid
    end
  end
end
