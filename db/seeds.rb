User.destroy_all
Room.destroy_all

User.create!(
  email: "johndoe@example.com",
  password: "password",
  password_confirmation: "password"
)

User.create!(
  email: "lochandsome@example.com",
  password: "password",
  password_confirmation: "password"
)

8.times do |_i|
  User.create!(
    email: "#{Faker::Name.unique.name.split(' ').first.downcase}@example.com",
    password: "password",
    password_confirmation: "password"
  )
end

puts "10 users created successfully."

Room.create!(
  name: "General"
)

Room.create!(
  name: "Rails"
)

5.times do
  Room.create!(
    name: Faker::Coffee.origin.split(" ").first
  )
end

puts "7 rooms created successfully."
