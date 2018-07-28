class CreateBids < ActiveRecord::Migration[5.1]
  def change
    create_table :bids do |t|
      t.integer :bidder
      t.decimal :bid_price
      t.references :slot, foreign_key: true

      t.timestamps
    end
  end
end
