class ChangeColumnsOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :user_name, from: nil, to: ""
    change_column_default :users, :tel, from: nil, to: ""
    change_column_null :users, :birthdate, true

    remove_index :users, :user_name if index_exists?(:users, :user_name)
    remove_index :users, :tel if index_exists?(:users, :tel)
  end
end
