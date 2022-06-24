class CreateProductTransanctions < ActiveRecord::Migration[7.0]
  def change
    create_table :product_transanctions do |t|
      t.references :product, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
