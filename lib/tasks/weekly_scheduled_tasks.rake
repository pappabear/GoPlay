desc "Send weekly email alerts to subscribers"
task :weekly_notifications => :environment do
  UserMailer.weekly_notifications.deliver_now!
end

