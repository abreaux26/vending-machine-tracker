# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sam = Owner.create(name: "Sam's Snacks")
Owner.create(name: "Drew's Drinks")

@dons = sam.machines.create(location: "Don's Mixed Drinks")
@tb = sam.machines.create(location: "Turing Basement")

@snickers = Snack.create!(name: 'Snickers', price: 1.00)
@chips = Snack.create!(name: 'Chips', price: 3.00)
@cheezits = Snack.create!(name: 'Cheezits', price: 1.50)

MachineSnack.create!(machine: @dons, snack: @snickers)
MachineSnack.create!(machine: @dons, snack: @chips)
MachineSnack.create!(machine: @tb, snack: @cheezits)
