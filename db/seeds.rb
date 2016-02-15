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

v2 = Venue.create(  :name       => 'Mennen Arena',
                    :address1   => '161 E Hanover Ave',
                    :city       => 'morristown',
                    :state      => 'nj',
                    :zip        => '07960',
                    :phone      => '973-326-7651' )

v3 = Venue.create(  :name       => 'Raleigh Ice Plex',
                    :address1   => '2601 Raleigh Blvd',
                    :city       => 'raleigh',
                    :state      => 'nc',
                    :zip        => '27604',
                    :phone      => '919-878-9002' )

puts '...venues created.  Make sure the geocoding worked!!. Verify that latitudes and longitudes are filled in.'

