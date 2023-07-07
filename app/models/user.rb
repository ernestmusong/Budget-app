class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, foreign_key: :author_id, dependent: :destroy
  has_many :activities, foreign_key: :author_id, dependent: :destroy

  attribute :role, :string

  validates :name, presence: true

  def admin?
    role == 'admin'
  end
end
