class CreateOccasions < ActiveRecord::Migration
  def change
    create_table :occasions do |t|
      t.string :label
      t.date :date
      t.references :contact, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
