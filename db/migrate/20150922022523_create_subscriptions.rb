class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :stripe_token
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
