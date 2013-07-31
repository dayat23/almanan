class CreateAccountMembers < ActiveRecord::Migration
  def change
    create_table :account_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone
      t.string :email
      t.integer :city_id
      t.integer :state_id
      t.string :encrypted_password
      t.string :salt
      t.integer :role_id

      t.timestamps
    end
  end
end
