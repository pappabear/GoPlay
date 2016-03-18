require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  

  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@" + APP_NAME + ".com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
  

  test "password_reset" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@" + APP_NAME + ".com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end


  test "email to hq about a new user" do
    user = User.create(name: "Fox Mulder", email: "ufo.dude@fbi.gov", password: "lollip0p", password_confirmation: "lollip0p")
    mail = UserMailer.email_hq_about_new_user(user)
    assert_equal "New user: Fox Mulder", mail.subject
    assert_equal ["noreply@" + APP_NAME + ".com"], mail.from
  end


end
