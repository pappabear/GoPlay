puts 'Removing old data...'

EventType.destroy_all
Activity.destroy_all
Venue.destroy_all
User.destroy_all

puts 'Creating users...'

User.create(name: "Richard Tooke", email: "r2k@me.com", password: "lollip0p", password_confirmation: "lollip0p",
            activated: true,
            activated_at: Time.zone.now)

User.create(name: "Chip Irek", email: "chip.irek@gmail.com", password: "lollip0p", password_confirmation: "lollip0p",
            activated: true,
            admin: true,
            activated_at: Time.zone.now)

User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

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

v1 = Venue.create!(:name => 'Polar Ice House Wake Forest',
                   :address1 => '1839 S Main St',
                   :address2 => '#200',
                   :city => 'wake forest',
                   :state => 'nc',
                   :zip => '27587',
                   :phone => '919-654-9872')

v2 = Venue.create!(:name => 'Mennen Arena',
                   :address1 => '161 E Hanover Ave',
                   :city => 'morristown',
                   :state => 'nj',
                   :zip => '07960',
                   :phone => '973-326-7651')

v3 = Venue.create!(:name => 'Raleigh Ice Plex',
                   :address1 => '2601 Raleigh Blvd',
                   :city => 'raleigh',
                   :state => 'nc',
                   :zip => '27604',
                   :phone => '919-878-9002')

v4 = Venue.create!(:name => 'United Skates of America',
                   :address1 => '75 New Rd',
                   :city => 'Rumford',
                   :state => 'RI',
                   :zip => '02916',
                   :phone => Faker::PhoneNumber.cell_phone)

v5 = Venue.create!(:name => 'Dennis Lynch Arena',
                   :address1 => '25 Andrew D Ferland Way',
                   :city => 'Pawtucket',
                   :state => 'RI',
                   :zip => '02860',
                   :phone => Faker::PhoneNumber.cell_phone)

v6 = Venue.create!(:name => 'Bay State Arena',
                   :address1 => '393 Totten Pond Rd',
                   :address2 => '#201',
                   :city => 'Waltham',
                   :state => 'MA',
                   :zip => '02451',
                   :phone => Faker::PhoneNumber.cell_phone)

v7 = Venue.create!(:name => 'Veterans Memorial Rink',
                   :address1 => '359 Totten Pond Rd',
                   :city => 'Waltham',
                   :state => 'MA',
                   :zip => '02451',
                   :phone => Faker::PhoneNumber.cell_phone)

v8 = Venue.create!(:name => 'Floyd Hall Arena',
                   :address1 => '28 Clove Rd',
                   :city => 'Little Falls',
                   :state => 'NJ',
                   :zip => '07424',
                   :phone => Faker::PhoneNumber.cell_phone)

v9 = Venue.create!(:name => 'Ice House',
                   :address1 => '111 Midtown Bridge St',
                   :city => 'Hackensack',
                   :state => 'NJ',
                   :zip => '07601',
                   :phone => Faker::PhoneNumber.cell_phone)

v10 = Venue.create!(:name => 'Dr Pepper Center',
                    :address1 => '4020 W Plano Pkwy',
                    :city => 'Plano',
                    :state => 'TX',
                    :zip => '75093',
                    :phone => Faker::PhoneNumber.cell_phone)

v11 = Venue.create!(:name => 'Some rink in Dallas',
                    :address1 => '2610 Allen St',
                    :address2 => '#5200',
                    :city => 'Dallas',
                    :state => 'TX',
                    :zip => '76040',
                    :phone => Faker::PhoneNumber.cell_phone)


v12 = Venue.create!(:name => 'Blades of Glory',
                    :address1 => '1400 S Pipeline Rd',
                    :city => 'Euless',
                    :state => 'TX',
                    :zip => '76040',
                    :phone => Faker::PhoneNumber.cell_phone)


puts '...venues created.  Make sure the geocoding worked!!. Verify that latitudes and longitudes are filled in.'

puts 'Creating events...'
puts '   ...an old OLD event, should not be returned in search results...'
Event.create!(:activity_id => Activity.last.id,
              :venue_id => Venue.last.id,
              :title => 'Dummy!!',
              :start_date => Date.today.advance(:days => -1), #Date.tomorrow.strftime("%m/%d/%Y"),
              :start_time => '8:00 pm',
              :subtitle => Faker::Lorem.sentence,
              :description => Faker::Lorem.paragraph,
              :details => Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
              :price => '$10',
              :restrictions => Faker::Lorem.paragraph,
              :info_url => Faker::Internet.url,
              :registration_url => Faker::Internet.url)


puts '   ...one at The Factory...'
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


puts '   ...one at Mennen'
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


puts '   ...and a Vonhoosits.'
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

puts 'Done.'
