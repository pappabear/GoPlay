require 'test_helper'

class VenuesControllerTest < ActionController::TestCase

  setup do
    @venue = venues(:factory)
    @user = users(:michael)
  end


  test "should redirect venues index when not logged in" do
    get :index
    assert_redirected_to login_url
  end


  test "should redirect venue edit when not logged in" do
    get :edit, id: @venue
    assert_redirected_to login_url
  end

  test "should redirect venue update when not logged in" do
    patch :update, id: @venue, venue: { name: @venue.name + '-e' }
    assert_redirected_to login_url
  end


  test "should get venues" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_not_nil assigns(:venues)
  end


  test "should get venue" do
    log_in_as(@user)
    get :show, id: @venue
    assert_response :success
    assert_not_nil assigns(:venue)
  end


  test "should get new venue" do
    log_in_as(@user)
    get :new
    assert_response :success
  end


  test "should edit venue" do
    log_in_as(@user)
    get :edit, id: @venue
    assert_response :success
  end


  test "should create venue" do
    log_in_as(@user)
    assert_difference('Venue.count') do
      post :create, venue: { name: @venue.name + '-new', address1: @venue.address1, city: @venue.city, state: @venue.state }
    end
    assert_redirected_to venues_path
  end


  test "should update venue" do
    log_in_as(@user)
    patch :update, id: @venue, venue: { name: @venue.name + '-e' }
    assert_redirected_to venues_path
  end


  test "should destroy venue" do
    log_in_as(@user)
    assert_difference('Venue.count', -1) do
      delete :destroy, id: @venue
    end
    assert_redirected_to venues_path
  end


end
