desc "Send daily email alerts to subscribers"
task :daily_notifications => :environment do
  UserMailer.daily_notifications.deliver_now!
end