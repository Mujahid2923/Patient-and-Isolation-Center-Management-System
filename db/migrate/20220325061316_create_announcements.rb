class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements do |t|
      t.string :title, null: false
      t.text :description
      t.references :user, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
