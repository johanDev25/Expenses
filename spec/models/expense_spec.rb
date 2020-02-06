require 'rails_helper'

RSpec.describe Expense, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:type) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:concept) }
  it { is_expected.to validate_numericality_of(:amount) }
end
