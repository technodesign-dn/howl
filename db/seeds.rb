# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



def bio
  "#{Faker::Pokemon.move} #{Faker::Job.position} at #{Faker::Company.name}"
end

User.destroy_all

100.times do
  User.create(
    full_name: Faker::Name.name,
    bio: bio,
    email: Faker::Internet.email,
    password: "password"
  )
end
