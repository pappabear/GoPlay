require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:michael)
  end


  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
                                    email: "user@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end


  test "successful edit with friendly forwarding" do
    log_in_as(@user)
    get edit_user_path(@user)
    # assert_redirected_to edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to edit_user_path(@user)
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end


  test "successful choose activities to follow" do

    # get 2 activity_ids to play with
    act1 = Activity.first.id
    act2 = Activity.last.id

    log_in_as(@user)
    get user_activities_path(@user)

    patch user_path(@user), user: { id:  @user.id, activity_ids: [act1, act2]}

    assert_not flash.empty?
    assert_redirected_to edit_user_path(@user)
    @user.reload

    c = @user.activities.count
    assert_equal c,  2

  end


end
