require 'test_helper'

class FeedbackEmailsControllerTest < ActionController::TestCase


  def setup
    @user       = users(:archer)
  end


  test "should get new" do
    get :new
    assert_response :success
  end


  test "should NOT create a feedback email if no user contact info" do
    assert_no_difference('FeedbackEmail.count') do
      post :create, feedback_email: { name: 'Some dude', email: 'a@b.c', message: 'Your site rocks!' }
    end
    assert_redirected_to root_path
  end


end
