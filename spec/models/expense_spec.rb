require 'rails_helper'

RSpec.describe Expense, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:type) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:concept) }
end
