class AddPriceToSnacks < ActiveRecord::Migration[5.1]
  def change
    add_column :snacks, :price, :decimal, precision: 5, scale: 2
  end
end
