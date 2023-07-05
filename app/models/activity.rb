class Activity < ApplicationRecord
    belongs_to :author, class_name: 'User'
    has_many :categories

    validates :name, presence: true
    validates :categories, presence: true
    validates :amount, presence: true
    validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
    