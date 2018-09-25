class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.string :title
      t.string :olx_id
      t.string :olx_url
      t.float :price
      t.boolean :is_new

      t.timestamps
    end
  end
end
