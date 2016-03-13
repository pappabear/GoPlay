require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  setup do
    @event = events(:pickup)
    @venue = venues(:factory)
    @user = users(:michael)
    @activity = activities(:hockey)
  end


  test "should redirect event edit when not logged in" do
    get :edit, id: @event
    assert_redirected_to login_url
  end


  test "should redirect event update when not logged in" do
    patch :update, id: @event, event: { title: @event.title + '-e', venue_id: @venue, activity_id: @activity, start_date: Date.today, start_time: '20:00' }
    assert_redirected_to login_url
  end


  test "should redirect new event page when not logged in" do
    get :new
    assert_redirected_to login_url
  end


  test "should redirect event create when not logged in" do
    post :create, event: { title: @event.title + '-new', venue_id: @venue, activity_id: @activity, start_date: Date.today, start_time: '20:00' }
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Venue.count' do
      delete :destroy, id: @event
    end
    assert_redirected_to login_url
  end



  test "should get events list" do
    log_in_as(@user)
    get :index, page: 1
    assert_response :success
    assert_not_nil assigns(:events)
  end


  test "should get event details page" do
    log_in_as(@user)
    get :show, id: @event
    assert_response :success
    assert_not_nil assigns(:event)
  end


  test "should get new event page" do
    log_in_as(@user)
    get :new
    assert_response :success
  end


  test "should get edit event page" do
    log_in_as(@user)
    get :edit, id: @event
    assert_response :success
  end


  test "should update event" do
    log_in_as(@user)
    patch :update, id: @event, event: { title: @event.title + '-e', venue_id: @venue, activity_id: @activity, start_date: Date.today.strftime("%m/%d/%Y"), start_time: '20:00' }
    assert_redirected_to root_path
  end


  test "should create new event" do
    log_in_as(@user)
    assert_difference('Event.count') do
      post :create, event: { title: @event.title + '-new', venue_id: @venue, activity_id: @activity, start_date: Date.today.strftime("%m/%d/%Y"), start_time: '20:00' }
    end

    assert_redirected_to root_path #activity_path(assigns(:activity))
  end


  test "should destroy event" do
    log_in_as(@user)
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end
    assert_redirected_to events_path
  end


end
