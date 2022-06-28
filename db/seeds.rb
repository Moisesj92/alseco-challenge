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
  email: "test1@test.com",
  password: "123123123",
  birthday: Faker::Date.between(from: 40.years.ago, to: Date.today),
  role: :retailer
)
User.create!(
  first_name: "arsenio",
  email: "test2@test.com",
  password: "123123123",
  birthday: Faker::Date.between(from: 40.years.ago, to: Date.today),
  role: :supplier
)
User.create(
  first_name: "arsenio",
  email: "test3@test.com",
  password: "123123123",
  birthday: Faker::Date.between(from: 40.years.ago, to: Date.today),
  role: :client
)

50.times do
  User.create!(
    first_name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "123123123",
    birthday: Faker::Date.between(from: 40.years.ago, to: Date.today),
    role: [0, 1, 2].sample
  )
end

p 'Creating products'
owner_ids = User.where(role: ['supplier','retailer']).pluck(:id)
prices = [15000, 20000, 30000, 42000, 53000]
100.times do
  Product.create!(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    sku: Faker::Number.number(digits: 10),
    status: [0, 1].sample,
    price: prices.sample,
    user: User.find(owner_ids.sample)
  )
end
