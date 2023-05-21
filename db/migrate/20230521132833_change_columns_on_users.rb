# frozen_string_literal: true

class ChangeColumnsOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.change_default :user_name, from: nil, to: ''
      t.change_default :tel, from: nil, to: ''
      t.change_null :birthdate, true
    end

    remove_index :users, :user_name if index_exists?(:users, :user_name)
    remove_index :users, :tel if index_exists?(:users, :tel)
  end
end
