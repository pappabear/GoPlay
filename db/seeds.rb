require 'csv'

puts 'Removing old data...'

EventType.destroy_all
Activity.destroy_all
Venue.destroy_all
User.destroy_all
Event.destroy_all

puts 'Creating users...'

User.create(name: "Richard Tooke", email: "r2k@me.com", password: "lollip0p", password_confirmation: "lollip0p",
            phone: "9196495383", activated: true, activated_at: Time.zone.now)

User.create(name: "Chip Irek", email: "chip.irek@gmail.com", password: "lollip0p", password_confirmation: "lollip0p",
            activated: true,
            admin: true,
            activated_at: Time.zone.now)

puts 'Creating activities...'

a1 = Activity.create(:name => 'Ice Hockey')
a2 = Activity.create(:name => 'Field Hockey')
a3 = Activity.create(:name => 'Soccer')
a4 = Activity.create(:name => 'Music')
a5 = Activity.create(:name => 'Golf')
a6 = Activity.create(:name => 'Cricket')

puts 'Creating event types...'

a1.event_types.create(:name => 'Join an Adult League')
a1.event_types.create(:name => 'Player Sub')
a1.event_types.create(:name => 'Goalie Sub')
a1.event_types.create(:name => 'Referee Sub')
a1.event_types.create(:name => 'Pickup / Open Hockey')
a1.event_types.create(:name => 'Adult League Tournament')
a1.event_types.create(:name => 'Private Pickup')
a1.event_types.create(:name => 'Lessons / Coaching')

a3.event_types.create(:name => 'Join an Adult League')
a3.event_types.create(:name => 'Player Sub')
a3.event_types.create(:name => 'Goalie Sub')
a3.event_types.create(:name => 'Referee Sub')
a3.event_types.create(:name => 'Pickup')
a3.event_types.create(:name => 'Adult League Tournament')
a3.event_types.create(:name => 'Private Pickup')
a3.event_types.create(:name => 'Lessons / Coaching')

a6.event_types.create(:name => 'Weekend Friendly')


puts 'Creating venues...'

CSV.foreach("db/venues.csv", headers: true) do |row|
  h = row.to_hash
  Venue.create!(:name => h['Name'],
                :address1 => h['Addr1'],
                :address2 => h['Addr2'],
                :city => h['City'],
                :state => h['State'],
                :zip => h['Zip'],
                :phone => h['Phone'],
                :url => h['URL'])
end

puts '...venues created.  Make sure the geocoding worked!!. Verify that latitudes and longitudes are filled in.'

puts 'Creating events...'
Event.create!(:activity_id => Activity.first.id,
              :event_type_id => EventType.where('name=?', 'Player Sub').first.id,
              :venue_id => Venue.first.id,
              :title => 'B/C league game with The Whiners',
              :subtitle => "I need a D for tonight's game",
              :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
              :start_time => '10:15 pm',
              :created_by => User.last.name,
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
              :title => 'A-league - goalie needed tonight!',
              :subtitle => 'Text me @ 321-215-5568',
              :start_date => Date.today.strftime("%m/%d/%Y"),
              :start_time => '11:00 pm',
              :created_by => User.last.name,
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
              :subtitle => 'Text me @ 321-215-5568',
              :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
              :start_time => '8:00 pm',
              :created_by => User.last.name,
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
              :created_by => User.last.name,
              :price => '$10')

Event.create!(:activity_id => Activity.first.id,
              :venue_id => Venue.first.id,
              :title => 'Stick and Puck',
              :start_date => Date.tomorrow.strftime("%m/%d/%Y"),
              :start_time => '4:30 pm',
              :created_by => User.last.name,
              :price => '$10')


puts 'Done.'
