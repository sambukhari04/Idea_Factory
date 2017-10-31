# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PASSWORD = 'hello'

Idea.destroy_all
User.destroy_all
Review.destroy_all

10.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end
users = User.all

100.times.each do
  Idea.create(
    title: Faker::Friends.character,
    description: Faker::Seinfeld.quote,
    user: users.sample
  )
end
ideas = Idea.all

ideas.each do |idea|
  rand(0..5).times.each do
    Review.create(
      body: Faker::TheFreshPrinceOfBelAir.quote,
      idea: idea,
      user: users.sample
    )
  end
end

reviews = Review.all



puts Cowsay.say("Created #{users.count} users", :tux)
puts Cowsay.say("Created #{ideas.count} ideas", :dragon)
puts "Created #{reviews.count} reviews"
