class CreateTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :transfers do |t|
      t.integer :to_facility, null: false
      t.date :date, index: true, null: false
      t.references :patient, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
