require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase

  setup do
    @activity = activities(:hockey)
    @user = users(:michael)
  end


  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end


  test "should redirect edit when not logged in" do
    get :edit, id: @activity
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @activity, activity: { name: @activity.name + '-e' }
    assert_redirected_to login_url
  end


  test "should get index" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_not_nil assigns(:activities)
  end


  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end


  test "should create activity" do
    log_in_as(@user)
    assert_difference('Activity.count') do
      post :create, activity: { name: @activity.name + '-new' }
    end

    assert_redirected_to activities_path #activity_path(assigns(:activity))
  end


  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @activity
    assert_response :success
  end


  test "should update activity" do
    log_in_as(@user)
    patch :update, id: @activity, activity: { name: @activity.name + '-e' }
    assert_redirected_to activities_path
  end


  test "should destroy activity" do
    log_in_as(@user)
    assert_difference('Activity.count', -1) do
      delete :destroy, id: @activity
    end

    assert_redirected_to activities_path
  end


end
