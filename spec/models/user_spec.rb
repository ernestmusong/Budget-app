require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = User.create(name: 'Test user', email: 'test@gmail.com', password: '123456',
                         password_confirmation: '123456')
  end

  describe '#Validations' do
    it 'User name  must not be nil' do
      @user1.name = nil
      expect(@user1).not_to be_valid
    end
  end
end
