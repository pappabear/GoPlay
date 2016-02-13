require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "GoPlay"
  end


  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | GoPlay"
  end


  test "should get news" do
    get :news
    assert_response :success
    assert_select "title", "News | GoPlay"
  end


  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | GoPlay"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | GoPlay"
  end
end
