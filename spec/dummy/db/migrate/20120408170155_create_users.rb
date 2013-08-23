class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :norm_address
      t.string :sec_address
      t.string :picture
      t.decimal :latitude, precision: 18, scale: 15
      t.decimal :longitude, precision: 18, scale: 15
      t.boolean :gmaps

      t.string :country
      t.decimal :oest, precision: 10, scale: 6 
      t.decimal :nord, precision: 10, scale: 6 
      t.string :town
      t.string :zip_code 

      t.timestamps
    end
  end
end
