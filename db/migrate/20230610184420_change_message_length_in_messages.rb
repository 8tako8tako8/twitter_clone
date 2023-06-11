# frozen_string_literal: true

class ChangeMessageLengthInMessages < ActiveRecord::Migration[7.0]
  def up
    change_column :messages, :message, :string, limit: 100
  end

  def down
    change_column :messages, :message, :string, limit: nil
  end
end
