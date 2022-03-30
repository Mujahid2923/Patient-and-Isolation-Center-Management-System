class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.integer :cid, null: false
      t.string :phone_number, null: false
      t.date :joining_date, index: true, null: false
      t.date :release_date, index: true, null: false
      t.string :diseases, null: false
      t.integer :active, null: false
      t.references :facility, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
