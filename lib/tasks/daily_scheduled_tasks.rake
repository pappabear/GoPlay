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
                :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
                :start_time => '10:15 pm',
                :price => '$10')
                #:subtitle => Faker::Lorem.sentence,
                #:description => Faker::Lorem.paragraph,
                #:details => Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
                #:restrictions => Faker::Lorem.paragraph,
                #:info_url => Faker::Internet.url,
                #:registration_url => Faker::Internet.url

  Event.create!(:activity_id => Activity.first.id,
                :event_type_id => EventType.where('name=?', 'Goalie Sub').first.id,
                :venue_id => Venue.where('name=?', 'Mennen Arena').first.id,
                :title => 'A league - goalie needed tonight!',
                :start_date => Date.today.strftime("%m/%d/%Y"),
                :start_time => '11:00 pm',
                :price => '$10')
                #:subtitle => Faker::Lorem.sentence,
                #:description => Faker::Lorem.paragraph,
                #:details => Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
                #:restrictions => Faker::Lorem.paragraph,
                #:info_url => Faker::Internet.url,
                #:registration_url => Faker::Internet.url

  Event.create!(:activity_id => Activity.first.id,
                :venue_id => Venue.first.id,
                :title => 'Vonhoosits',
                :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
                :start_time => '8:00 pm',
                :price => '$10')
                #:subtitle => Faker::Lorem.sentence,
                #:description => Faker::Lorem.paragraph,
                #:details => Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
                #:restrictions => Faker::Lorem.paragraph,
                #:info_url => Faker::Internet.url,
                #:registration_url => Faker::Internet.url

  Event.create!(:activity_id => Activity.first.id,
                :venue_id => Venue.first.id,
                :title => 'Stick and Puck',
                :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
                :start_time => '11:00 am',
                :price => '$10')

  Event.create!(:activity_id => Activity.first.id,
                :venue_id => Venue.first.id,
                :title => 'Stick and Puck',
                :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
                :start_time => '4:30 pm',
                :price => '$10')

end