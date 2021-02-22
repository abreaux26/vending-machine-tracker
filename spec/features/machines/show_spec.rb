require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @sam = Owner.create(name: "Sam's Snacks")

    @dons = @sam.machines.create(location: "Don's Mixed Drinks")
    @tb = @sam.machines.create(location: "Turing Basement")

    @snickers = Snack.create!(name: 'Snickers', price: 1.00)
    @chips = Snack.create!(name: 'Chips', price: 3.00)
    @cheezits = Snack.create!(name: 'Cheezits', price: 1.50)

    MachineSnack.create!(machine: @dons, snack: @snickers)
    MachineSnack.create!(machine: @dons, snack: @chips)
    MachineSnack.create!(machine: @tb, snack: @cheezits)
  end

  describe 'When I visit a vending machine show page' do
    it 'I see the name of all of the snacks associated with that vending machine along with their price' do
      visit machine_path(@dons)

      within("#snack-#{@snickers.id}") do
        expect(page).to have_content(@snickers.name)
        expect(page).to have_content(@snickers.price)
      end

      within("#snack-#{@chips.id}") do
        expect(page).to have_content(@chips.name)
        expect(page).to have_content(@chips.price)
      end

      expect(page).not_to have_content(@cheezits.name)
      expect(page).not_to have_content(@cheezits.price)
    end

    it 'I see an average price for all of the snacks in that machine' do
      visit  machine_path(@dons)

      expect(page).to have_content(@dons.snacks.average_price)
    end
  end
end
