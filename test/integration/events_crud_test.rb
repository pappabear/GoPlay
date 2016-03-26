require 'test_helper'

class EventsCrudTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:michael)
  end


  test "successfully list events" do
    log_in_as(@user)
    get events_path
    assert_template 'events/index'
    assert_response :success
    assert assigns(:events)
  end


  test "successfully add a new event" do
    log_in_as(@user)
    get new_event_path
    assert_template 'events/new'

    assert_difference 'Event.count', 1 do
      post events_path, event: { activity_id: Activity.first.id,
                                 venue_id: Venue.first.id,
                                 title: "Blades of Glory competition",
                                 price: "$10",
                                 restrictions: ">18",
                                 start_date: Date.today.strftime("%m/%d/%Y"),
                                 start_time: "8pm",
                                 is_urgent: false }
    end

    assert_not flash.empty?
    assert_redirected_to root_path
  end


  test "successfully update an event" do
    log_in_as(@user)
    a = Event.last
    old_title = a.title

    get edit_event_path(a.id)
    assert_template 'events/edit'

    patch event_path(a.id), event: { title: old_title + "-e" }
    assert_not flash.empty?
    assert_redirected_to root_path
    a2 = Event.last
    assert_equal old_title + "-e",  a2.title
  end


  test "successfully delete an event" do
    log_in_as(@user)
    a = Event.last

    assert_difference 'Event.count', -1 do
      delete_via_redirect event_path(a.id)
    end

    assert_not flash.empty?
    assert_equal path, events_path

  end


end
