class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.integer :relationship

      t.timestamps null: false
    end
  end
end
