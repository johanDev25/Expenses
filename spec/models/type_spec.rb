require 'rails_helper'

RSpec.describe Type, type: :model do
  it { is_expected.to have_many(:expenses) }
end
