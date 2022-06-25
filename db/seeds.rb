# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require 'faker'

p 'Creating users'

User.create(
  first_name: "arsenio",
  email: "moises.jimenez92@gmail.com",
  password: "123123123",
  age: 29,
  role: "retailer"
)
User.create(
  first_name: "arsenio",
  email: "moises.jimenez93@gmail.com",
  password: "123123123",
  age: 29,
  role: "supplier"
)
User.create(
  first_name: "arsenio",
  email: "moises.jimenez94@gmail.com",
  password: "123123123",
  age: 29,
  role: "client"
)

50.times do
  User.create(
    first_name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "123123123",
    age: Faker::Number.between(from: 18, to: 80),
    role: %w[retailer supplier client].sample
  )
end

p 'Creating products'
owner_ids = User.where(role: ['supplier','retailer']).pluck(:id)
prices = [15000, 20000, 30000, 42000, 53000]
100.times do
  Product.create!(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    status: [0, 1].sample,
    price: prices.sample,
    user: User.find(owner_ids.sample)
  )
end
