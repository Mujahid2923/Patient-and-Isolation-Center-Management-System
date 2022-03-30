class CreateFacilities < ActiveRecord::Migration[6.1]
  def change
    create_table :facilities do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
