require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  def setup
  @expense = expenses(:one)
  end

 test 'invalid without concept' do
   @expense.concept = nil
   refute @expense.valid?
   assert_not_nil @expense.errors[:concept]
 end

 test 'invalid without amount' do
   @expense.amount = nil
   refute @expense.valid?
   assert_not_nil @expense.errors[:amount]
 end

 test "amount should be numeric" do
 invalid_amount = %w[asdffdsa 123s32 ]
 invalid_amount.each do |amount|
 @expense.amount = amount
 assert_not @expense.valid? , "#{amount.inspect} should be valid"
 end
end

end
