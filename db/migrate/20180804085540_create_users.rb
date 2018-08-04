class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.references :role, foreign_key: true
      t.string :reset_password_token
      t.datetime :reset_password_expires

      t.timestamps
    end
  end
end
