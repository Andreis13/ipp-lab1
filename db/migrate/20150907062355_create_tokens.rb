class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.belongs_to :app,        null: false
      t.belongs_to :account,   null: false
      t.string     :token,      null: false
      t.datetime   :created_at, null: false
    end
  end
end
