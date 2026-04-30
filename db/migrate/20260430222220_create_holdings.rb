class CreateHoldings < ActiveRecord::Migration[8.1]
  def change
    create_table :holdings do |t|
      t.string :symbol
      t.integer :quantity
      t.float :average_price
      t.references :portfolio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
