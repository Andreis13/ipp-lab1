class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email,    null: false
      t.string :password, null: false
      t.timestamps        null: false
    end
  end
end
