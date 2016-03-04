desc "Send daily email alerts to subscribers"
task :daily_notifications => :environment do
  UserMailer.daily_notifications.deliver_now!
end

desc "Create example events for finding in search"
task :re_seed_events => :environment do
  Event.create!(:activity_id => Activity.first.id,
                :event_type_id => EventType.where('name=?', 'Player Sub').first.id,
                :venue_id => Venue.first.id,
                :title => 'Skate at the Factory',
                :start_date => Date.tomorrow,
                :start_time => '8:00 pm',
                :subtitle => Faker::Lorem.sentence,
                :description => Faker::Lorem.paragraph,
                :details => Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
                :price => '$10',
                :restrictions => Faker::Lorem.paragraph,
                :info_url => Faker::Internet.url,
                :registration_url => Faker::Internet.url)

  Event.create!(:activity_id => Activity.first.id,
                :event_type_id => EventType.where('name=?', 'Goalie Sub').first.id,
                :venue_id => Venue.where('name=?', 'Mennen Arena').first.id,
                :title => 'Skate at Mennen',
                :start_date => Date.tomorrow,
                :start_time => '8:00 pm',
                :subtitle => Faker::Lorem.sentence,
                :description => Faker::Lorem.paragraph,
                :details => Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
                :price => '$10',
                :restrictions => Faker::Lorem.paragraph,
                :info_url => Faker::Internet.url,
                :registration_url => Faker::Internet.url)

  Event.create!(:activity_id => Activity.first.id,
                :venue_id => Venue.first.id,
                :title => 'Vonhoosits',
                :start_date => Date.tomorrow,
                :start_time => '8:00 pm',
                :subtitle => Faker::Lorem.sentence,
                :description => Faker::Lorem.paragraph,
                :details => Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
                :price => '$10',
                :restrictions => Faker::Lorem.paragraph,
                :info_url => Faker::Internet.url,
                :registration_url => Faker::Internet.url)

  k = Venue.first.id
  9.times do |i|
    30.times do |n|
      Event.create!(:activity_id => Activity.first.id,
                    :venue_id => k,
                    :title => "Dummy example-#{n+1} event",
                    :start_date => Date.tomorrow,
                    :start_time => '8:00 pm',
                    :subtitle => Faker::Lorem.sentence,
                    :description => Faker::Lorem.paragraph,
                    :details => Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
                    :price => '$10',
                    :restrictions => Faker::Lorem.paragraph,
                    :info_url => Faker::Internet.url,
                    :registration_url => Faker::Internet.url)
    end
    k += 1
  end

end