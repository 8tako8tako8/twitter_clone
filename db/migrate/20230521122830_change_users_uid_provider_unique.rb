# frozen_string_literal: true

class ChangeUsersUidProviderUnique < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :uid, false
    change_column_default :users, :provider, from: nil, to: ''
    change_column_null :users, :provider, false
    add_index :users, %i[uid provider], unique: true
  end
end
