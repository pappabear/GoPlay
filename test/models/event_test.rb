require 'test_helper'

class EventTest < ActiveSupport::TestCase


  def setup
    @event = events(:pickup)
    @pk = @event.id
  end


  test "valid time should be OK" do
    @event.start_time = "10:00pm"
    assert @event.save
  end


  test "blank time should fail" do
    @event.start_time = ""
    assert_not @event.save
  end


  test "2pm should become 2:00pm" do
    @event.start_time = "2pm"
    assert @event.save
    o = Event.find(@pk)
    assert_equal " 2:00 PM", o.start_time
  end

  test "230pm should become 2:30pm" do
    @event.start_time = "230pm"
    assert @event.save
    o = Event.find(@pk)
    assert_equal " 2:30 PM", o.start_time
  end

  test "1000 should fail" do
    @event.start_time = "1000"
    assert_not @event.save
  end

  test "1000pm should become 10:00pm" do
    @event.start_time = "1000pm"
    assert @event.save
    o = Event.find(@pk)
    assert_equal "10:00 PM", o.start_time
  end

  test "1030pm should become 10:30pm" do
    @event.start_time = "1030pm"
    assert @event.save
    o = Event.find(@pk)
    assert_equal "10:30 PM", o.start_time
  end

end
