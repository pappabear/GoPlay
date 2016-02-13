require 'test_helper'

class EventTypesControllerTest < ActionController::TestCase

  setup do
    @activity = activities(:hockey)
    @event_type = event_types(:pickup)
  end


  #test "should get index" do
  #  get :index, activity_id: @activity.id
  #  assert_response :success
  #  assert_not_nil assigns(:event_types)
  #end


  test "should get new" do
    get :new, activity_id: @activity.id
    assert_response :success
  end


  #test "should create an item" do
  #  assert_difference('Item.count') do
  #    post :create, format: :js, list_id:@item.list_id, item: { name: 'test', is_complete: false }
  #  end
  #end


  test "should create event_type" do
    assert_difference('EventType.count') do
      post :create, activity_id: @activity.id, event_type: { name: @event_type.name + ' new' }
    end

    assert_redirected_to @activity
  end


  #test "should show event_type" do
  #  get :show, id: @event_type
  #  assert_response :success
  #end


  test "should get edit" do
    get :edit, activity_id: @activity.id, id: @event_type
    assert_response :success
  end


  test "should update event_type" do
    patch :update, id: @event_type, activity_id: @activity.id, event_type: { name: @event_type.name + '-e' }
    assert_redirected_to @activity
  end


  test "should destroy event_type" do
    assert_difference('EventType.count', -1) do
      delete :destroy, activity_id: @activity.id, id: @event_type
    end

    assert_redirected_to @activity
  end


end
