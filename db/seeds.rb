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

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

puts 'Creating activities...'

a1 = Activity.create( :name => 'Ice Hockey' )
a2 = Activity.create( :name => 'Field Hockey' )
a3 = Activity.create( :name => 'Soccer' )
a4 = Activity.create( :name => 'Music' )
a5 = Activity.create( :name => 'Golf' )
a6 = Activity.create( :name => 'Cricket' )

puts 'Creating event types...'

a1.event_types.create( :name => 'Join an Adult League')
a1.event_types.create( :name => 'Player Sub')
a1.event_types.create( :name => 'Goalie Sub')
a1.event_types.create( :name => 'Referee Sub')
a1.event_types.create( :name => 'Pickup / Open Hockey')
a1.event_types.create( :name => 'Adult League Tournament')
a1.event_types.create( :name => 'Private Pickup')
a1.event_types.create( :name => 'Lessons / Coaching')

a3.event_types.create( :name => 'Join an Adult League')
a3.event_types.create( :name => 'Player Sub')
a3.event_types.create( :name => 'Goalie Sub')
a3.event_types.create( :name => 'Referee Sub')
a3.event_types.create( :name => 'Pickup')
a3.event_types.create( :name => 'Adult League Tournament')
a3.event_types.create( :name => 'Private Pickup')
a3.event_types.create( :name => 'Lessons / Coaching')

a6.event_types.create( :name => 'Weekend Friendly')


puts 'Creating venues...'

v1 = Venue.create(  :name       => 'Polar Ice House Wake Forest',
                    :address1   => '1839 S Main St',
                    :address2   => '#200',
                    :city       => 'wake forest',
                    :state      => 'nc',
                    :zip        => '27587',
                    :phone      => '919-654-9872')
puts '... added ' + v1.name + ' in ' + v1.city + ' ' + v1.zip

v2 = Venue.create(  :name       => 'Mennen Arena',
                    :address1   => '161 E Hanover Ave',
                    :city       => 'morristown',
                    :state      => 'nj',
                    :zip        => '07960',
                    :phone      => '973-326-7651' )
puts '... added ' + v2.name + ' in ' + v2.city + ' ' + v2.zip

v3 = Venue.create(  :name       => 'Raleigh Ice Plex',
                    :address1   => '2601 Raleigh Blvd',
                    :city       => 'raleigh',
                    :state      => 'nc',
                    :zip        => '27604',
                    :phone      => '919-878-9002' )
puts '... added ' + v3.name + ' in ' + v3.city + ' ' + v3.zip

v4 = Venue.create(  :name       => 'United Skates of America',
               :address1   => '75 New Rd',
               :city       => 'Rumford',
               :state      => 'RI',
               :zip        => '02916',
               :phone      => Faker::PhoneNumber.cell_phone )
puts '... added ' + v4.name + ' in ' + v4.city + ' ' + v4.zip

v5 = Venue.create(  :name       => 'Dennis Lynch Arena',
               :address1   => '25 Andrew D Ferland Way',
               :city       => 'Pawtucket',
               :state      => 'RI',
               :zip        => '02860',
               :phone      => Faker::PhoneNumber.cell_phone )
puts '... added ' + v5.name + ' in ' + v5.city + ' ' + v5.zip

v6 = Venue.create(  :name       => 'Bay State Arena',
               :address1   => '393 Totten Pond Rd',
               :address2   => '#201',
               :city       => 'Waltham',
               :state      => 'MA',
               :zip        => '02451',
               :phone      => Faker::PhoneNumber.cell_phone )
puts '... added ' + v6.name + ' in ' + v6.city + ' ' + v6.zip

v7 = Venue.create(  :name       => 'Veterans Memorial Rink',
               :address1   => '359 Totten Pond Rd',
               :city       => 'Waltham',
               :state      => 'MA',
               :zip        => '02451',
               :phone      => Faker::PhoneNumber.cell_phone )
puts '... added ' + v7.name + ' in ' + v7.city + ' ' + v7.zip

v8 = Venue.create(  :name       => 'Floyd Hall Arena',
               :address1   => '28 Clove Rd',
               :city       => 'Little Falls',
               :state      => 'NJ',
               :zip        => '07424',
               :phone      => Faker::PhoneNumber.cell_phone )
puts '... added ' + v8.name + ' in ' + v8.city + ' ' + v8.zip

v9 = Venue.create(  :name       => 'Ice House',
               :address1   => '111 Midtown Bridge St',
               :city       => 'Hackensack',
               :state      => 'NJ',
               :zip        => '07601',
               :phone      => Faker::PhoneNumber.cell_phone )
puts '... added ' + v9.name + ' in ' + v9.city + ' ' + v9.zip

v10 = Venue.create(  :name       => 'Dr Pepper Center',
               :address1   => '4020 W Plano Pkwy',
               :city       => 'Plano',
               :state      => 'TX',
               :zip        => '75093',
               :phone      => Faker::PhoneNumber.cell_phone )
puts '... added ' + v10.name + ' in ' + v10.city + ' ' + v10.zip

# v11 = Venue.create(  :name       => Faker::Company.name,
#                :address1   => '2610 Allen St',
#                :address2   => '#5200',
#                :city       => 'Dallas',
#                :state      => 'TX',
#                :zip        => '76040',
#                :phone      => Faker::PhoneNumber.cell_phone )
# puts '... added ' + v11.name + ' in ' + v11.city + ' ' + v11.zip

# v12 = Venue.create(  :name       => Faker::Company.name,
#                :address1   => '1400 S Pipeline Rd',
#                :city       => 'Euless',
#                :state      => 'TX',
#                :zip        => '76040',
#                :phone      => Faker::PhoneNumber.cell_phone )
# puts '... added ' + v12.name + ' in ' + v12.city + ' ' + v12.zip

puts '...venues created.  Make sure the geocoding worked!!. Verify that latitudes and longitudes are filled in.'


