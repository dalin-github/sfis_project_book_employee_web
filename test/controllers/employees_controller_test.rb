require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index --skip-routes" do
    get employees_index --skip-routes_url
    assert_response :success
  end
end
