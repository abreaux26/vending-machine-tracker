require 'rails_helper'

RSpec.describe Snack do
  before :each do
    @snickers = Snack.create!(name: 'Snickers', price: 1.00)
    @chips = Snack.create!(name: 'Chips', price: 2.00)
    @cheezits = Snack.create!(name: 'Cheezits', price: 1.50)
  end

  describe 'relationships' do
    it { should have_many :machine_snacks }
    it { should have_many(:machines).through(:machine_snacks) }
  end

  describe 'class methods' do
    it 'returns average price' do
      sum = (@snickers.price + @chips.price + @cheezits.price)
      average_price = sum / Snack.count

      expect(Snack.average_price).to eq(1.50)
    end
  end
end
