require 'test_helper'

class ExpenseFlowTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper
  setup do
    Capybara.default_driver = :selenium_chrome
  end

  test "create a new expense from js" do
    visit expenses_path
    click_link "New Expense"
    select "Purchase", :from => "type_id"
    fill_in "date", with: Date.current
    fill_in "concept", with: "test concept"
    select "Home", :from => "category_id"
    fill_in "amount", with: 100
    click_button "Create"

    assert_current_path expenses_path
    assert_equal(Expense.last.concept, "test concept")
    assert_equal(Expense.last.date, Date.today)
    assert_equal(Expense.last.amount, 100)
  end
end
