class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :product_id
      t.string :image

      t.timestamps
    end
    add_index :pictures, :product_id
  end
end
