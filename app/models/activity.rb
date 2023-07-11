class Activity < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category

  validates :name, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def self.most_recent
    order(created_at: :desc)
  end
end
