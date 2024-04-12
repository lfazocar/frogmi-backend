class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :external_id
      t.string :title, null: false
      t.string :url, null: false
      t.string :place, null: false
      t.string :mag_type, null: false
      t.float :magnitude
      t.string :time
      t.boolean :tsunami
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
    add_index :features, :external_id, unique: true
  end
end
