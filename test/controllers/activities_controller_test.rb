require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase

  setup do
    @activity = activities(:hockey)
  end


  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activities)
  end


  test "should get new" do
    get :new
    assert_response :success
  end


  test "should create activity" do
    assert_difference('Activity.count') do
      post :create, activity: { name: @activity.name }
    end

    assert_redirected_to activities_path #activity_path(assigns(:activity))
  end


  test "should get edit" do
    get :edit, id: @activity
    assert_response :success
  end


  test "should update activity" do
    patch :update, id: @activity, activity: { name: @activity.name + '-e' }
    assert_redirected_to activities_path
  end


  test "should destroy activity" do
    assert_difference('Activity.count', -1) do
      delete :destroy, id: @activity
    end

    assert_redirected_to activities_path
  end


end
