require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
      #se crea una variale ocupando el objeto de fixtures llamado one
    @expense = expenses(:one)
  end

  test "should show expenses index" do
    get expenses_url
    assert_response :success
  end

  test "should not create expense" do
    get expenses_path
    assert_no_difference 'Expense.count' do
      post expenses_path ,xhr: true, params: { expense: {
        concept: "",
        amount: "aaa",
        date: "",
        category_id: "",
        type_id: "" }}
      end
    end
  end
