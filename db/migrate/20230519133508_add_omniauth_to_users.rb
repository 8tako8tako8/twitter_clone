# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  change_table :users, bulk: true do |t|
    t.string :provider, null: false, default: ''
    t.string :uid, null: false

    t.index [:provider, :uid], unique: true
  end
end
