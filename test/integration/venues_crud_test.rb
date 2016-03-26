require 'test_helper'

class VenuesCrudTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:michael)
  end


  test "successfully list venues" do
    log_in_as(@user)
    get venues_path
    assert_template 'venues/index'
    assert_response :success
    assert assigns(:venues)
  end


  test "successfully add a new venue" do
    log_in_as(@user)
    get new_venue_path
    assert_template 'venues/new'

    assert_difference 'Venue.count', 1 do
      post venues_path, venue: { name:  "The Ice Hole",
                                 address1: "10 Bayview Road",
                                 city: "Hopatcong",
                                 state: "NJ",
                                 zip: "07843",
                                 phone: "201-321-9876" }
    end

    assert_not flash.empty?
    assert_redirected_to venues_path
  end


  test "successfully update an venue" do
    log_in_as(@user)
    a = Venue.last
    old_name = a.name

    get edit_venue_path(a.id)
    assert_template 'venues/edit'

    patch venue_path(a.id), venue: { name: old_name + "-e" }
    assert_not flash.empty?
    assert_redirected_to venues_path
    a2 = Venue.last
    assert_equal old_name + "-e",  a2.name
  end


  test "successfully delete an venue" do
    log_in_as(@user)
    a = Venue.last

    assert_difference 'Venue.count', -1 do
      delete_via_redirect venue_path(a.id)
    end

    assert_not flash.empty?
    assert_equal path, venues_path

  end


end
