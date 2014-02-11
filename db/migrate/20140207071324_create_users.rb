class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :first_name
      t.string :last_name
      t.string :mobile_no
      t.string :email
      t.string :provider
      t.string :facebook_id
      t.string :fb_token
      t.string :password_hash
      t.string :password_salt
      t.string :gender
      t.text :address
      t.string :name
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country

      t.timestamps
    end
  end
end
