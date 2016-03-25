require 'test_helper'

class ActivitiesCrudTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:michael)
  end


  test "successfully list activities" do
    log_in_as(@user)
    get activities_path
    assert_template 'activities/index'
    assert_response :success
    assert assigns(:activities)
  end


  test "successfully add a new activity" do
    log_in_as(@user)
    get new_activity_path
    assert_template 'activities/new'

    assert_difference 'Activity.count', 1 do
      post activities_path, activity: { name:  "Soemthing new" }
    end

    assert_not flash.empty?
    assert_redirected_to activities_path
  end


  test "successfully update an activity" do
    log_in_as(@user)
    a = Activity.last
    old_name = a.name

    get edit_activity_path(a.id)
    assert_template 'activities/edit'

    patch activity_path(a.id), activity: { name: old_name + "-e" }
    assert_not flash.empty?
    assert_redirected_to activities_path
    a2 = Activity.last
    assert_equal old_name + "-e",  a2.name
  end


  test "successfully delete an activity" do
    log_in_as(@user)
    a = Activity.last

    assert_difference 'Activity.count', -1 do
      delete_via_redirect activity_path(a.id)
    end

    assert_not flash.empty?
    assert_equal path, activities_path

  end


end
