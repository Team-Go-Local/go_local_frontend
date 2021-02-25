class AddUidToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :int
    add_column :users, :token, :string
    remove_column :users, :password_digest
  end
end
