require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get expenses_url
    assert_response :success
    assert_not_nil assigns(:expenses)
  end
end
