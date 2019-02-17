require 'test_helper'

class TodotasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get todotasks_index_url
    assert_response :success
  end

  test "should get new" do
    get todotasks_new_url
    assert_response :success
  end

  test "should get edit" do
    get todotasks_edit_url
    assert_response :success
  end

  test "should get show" do
    get todotasks_show_url
    assert_response :success
  end

end
