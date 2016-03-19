require 'test_helper'

class FeedbackEmailsTest < ActionDispatch::IntegrationTest


  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end


  test "feedback emails should get created and sent" do
    get new_feedback_email_path
    assert_template 'feedback_emails/new'

    post feedback_emails_path, feedback_email: { name: 'Some dude', email: 'a@b.c', message: 'Your site rocks!' }
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end


end
