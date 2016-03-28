desc "Send daily email alerts to subscribers"
task :daily_notifications => :environment do
  UserMailer.daily_notifications.deliver_now!
end

desc "Create example events for finding in search"
task :re_seed_events => :environment do

  Event.where('start_date < ?', Date.today).each do |e|
    e.destroy!
  end

  Event.create!(:activity_id => Activity.first.id,
                :event_type_id => EventType.where('name=?', 'Player Sub').first.id,
                :venue_id => Venue.first.id,
                :title => 'B/C league game with The Whiners',
                :subtitle => "I need a D for tonight's game",
                :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
                :start_time => '10:15 pm',
                :created_by => User.last.name,
                :price => '$10')

  Event.create!(:activity_id => Activity.first.id,
                :event_type_id => EventType.where('name=?', 'Goalie Sub').first.id,
                :venue_id => Venue.where('name=?', 'Mennen Arena').first.id,
                :title => 'A-league - goalie needed tonight!',
                :subtitle => 'Text me @ 321-215-5568',
                :start_date => Date.today.strftime("%m/%d/%Y"),
                :start_time => '11:00 pm',
                :created_by => User.last.name,
                :price => '$10')

  Event.create!(:activity_id => Activity.first.id,
                :venue_id => Venue.first.id,
                :title => 'Vonhoosits',
                :subtitle => 'Text me @ 321-215-5568',
                :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
                :start_time => '8:00 pm',
                :created_by => User.last.name,
                :price => '$10')

  Event.create!(:activity_id => Activity.first.id,
                :venue_id => Venue.first.id,
                :title => 'Stick and Puck',
                :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
                :start_time => '11:00 am',
                :created_by => User.last.name,
                :price => '$10')

  Event.create!(:activity_id => Activity.first.id,
                :venue_id => Venue.first.id,
                :title => 'Stick and Puck',
                :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
                :start_time => '4:30 pm',
                :created_by => User.last.name,
                :price => '$10')

  UserMailer.daily_notifications.deliver_now!

end