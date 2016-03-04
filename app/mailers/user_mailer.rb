class UserMailer < ApplicationMailer


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end


  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end


  def email_hq_about_new_user(user)
    @user = user
    mail to: 'chip.irek@gmail.com', subject: "New user: " + @user.name
  end


  def daily_notifications
    puts 'Initiating the daily_notifications job...'
    subscribers = User.where('basic_notifications_frequency=?', 'daily').where('latitude is not null and longitude is not null')
    puts subscribers.count.to_s + ' subscriber(s) found.'

    subscribers.each do |sub|
      activities = sub.activities
      @events = Event.within(50, :origin => [ sub.latitude , sub.longitude ])
                                  .where(activity_id: activities)
                                  .where('start_date > ?', DateTime.now)
                                  .where('start_date < ?', Date.today.advance(:days=>7))
                                  .order('start_date')
      puts '    For ' + sub.email + ' there were ' + @events.count.to_s + ' event(s) found.'
      mail to: sub.email, subject: "Your GoPlay daily update"

    end

    puts '...completed sending daily_notifications.'
  end


  def weekly_notifications
    puts 'Initiating the daily_notifications job...'
    subscribers = User.where('basic_notifications_frequency=?', 'weekly').where('latitude is not null and longitude is not null')
    puts subscribers.count.to_s + ' subscriber(s) found.'

    subscribers.each do |sub|
      activities = sub.activities
      @events = Event.within(50, :origin => [ sub.latitude , sub.longitude ])
                    .where(activity_id: activities)
                    .where('start_date > ?', DateTime.now)
                    .where('start_date < ?', Date.today.advance(:days=>14))
                    .order('start_date')
      puts '    For ' + sub.email + ' there were ' + @events.count.to_s + ' event(s) found.'
      mail to: sub.email, subject: "Your GoPlay weekly update"

    end

    puts '...completed sending daily_notifications.'
  end


end
