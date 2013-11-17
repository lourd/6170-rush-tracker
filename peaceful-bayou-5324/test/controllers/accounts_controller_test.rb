require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get detail" do
    get :detail
    assert_response :success
  end

  test "should get verify" do
    get :verify
    assert_response :success
  end

  test "should get invite" do
    get :invite
    assert_response :success
  end

end
