puts 'Removing old data...'

EventType.destroy_all
Activity.destroy_all
User.destroy_all

puts 'Creating users...'

User.create(name: "Richard Tooke", email: "r2k@me.com", password: "lollip0p", password_confirmation: "lollip0p",
            activated: true,
            activated_at: Time.zone.now)

#User.create(name: "Chip Irek", email: "chip.irek@gmail.com", password: "lollip0p", password_confirmation: "lollip0p",
#            activated: true,
#            activated_at: Time.zone.now)

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
