# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  gender: 0,
  password: "foobar",
  password_confirmation: "foobar",
  date_of_birth: "1995-03-29",
  is_admin: true)
99.times do |n|
  name  = Faker::Name.name
  date_of_birth = "1970-01-01"
  Artist.create!(name: name,
    type_of_music: 1,
    date_of_birth: date_of_birth,
    gender: 1,
    artist_type: 0)
end
99.times do |n|
  name  = Faker::Name.name
  date_of_birth = "1970-01-01"
  Artist.create!(name: name,
    type_of_music: rand(2),
    date_of_birth: date_of_birth,
    gender: 1,
    artist_type: 1)
end
10.times do |c|
  name = Faker::Name.name
  Category.create! name: name
end
