class AddDevisePassword < ActiveRecord::Migration[5.0]
  def up
    rename_column :users, :encrypted_password, :legacy_password
    change_column :users, :legacy_password, :string, comment: "Password encrypted with legacy hashing, made obsolete by 'encrypted_password'."
    add_column :users, :encrypted_password, :string
  end

  def down
    remove_column :users, :encrypted_password, :string
    rename_column :users, :legacy_password, :encrypted_password
    change_column :users, :encrypted_password, :string, comment: ""
  end
end
