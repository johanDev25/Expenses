class Expense < ApplicationRecord
  validates :concept, :amount, :date, presence: true
  validates :amount, numericality: true

  belongs_to :category
  belongs_to :type
end
