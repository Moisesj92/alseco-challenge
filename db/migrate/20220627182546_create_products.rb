class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :sku, null: false
      t.integer :price
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
