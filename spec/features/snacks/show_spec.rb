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

  describe 'When I visit a snack show page' do
    it 'I see the name of that snack' do
      visit snack_path(@snickers)

      expect(page).to have_content(@snickers.name)
      expect(page).not_to have_content(@chips.name)
      expect(page).not_to have_content(@cheezits.name)
    end

    it 'I see the price for that snack' do
      visit snack_path(@snickers)

      expect(page).to have_content(@snickers.price)
      expect(page).not_to have_content(@chips.price)
      expect(page).not_to have_content(@cheezits.price)
    end

    it 'I see a list of locations with vending machines that carry that snack' do
      visit snack_path(@snickers)

      expect(page).to have_content(@dons.location)
      expect(page).not_to have_content(@tb.location)
    end

    it 'I see the average price for snacks in those vending machines' do
      visit snack_path(@snickers)

      expect(page).to have_content(@dons.snacks.average_price)
      expect(page).not_to have_content(@tb.snacks.average_price)
    end

    it 'I see a count of the different kinds of items in that vending machine.' do
      visit snack_path(@snickers)

      within("#machine-#{@dons.id}") do
        expect(page).to have_content(@dons.snacks.count)
        expect(page).not_to have_content(@tb.snacks.count)
      end
    end
  end
end
