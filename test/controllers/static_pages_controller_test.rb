require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", APP_NAME
  end


  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | " + APP_NAME
  end


  test "should get news" do
    get :news
    assert_response :success
    assert_select "title", "News | " + APP_NAME
  end


  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | " + APP_NAME
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact Us | " + APP_NAME
  end
end
