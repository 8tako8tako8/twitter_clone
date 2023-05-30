# frozen_string_literal: true

class ChangeTweetLengthInTweets < ActiveRecord::Migration[7.0]
  def up
    change_column :tweets, :tweet, :string, limit: 140
  end

  def down
    change_column :tweets, :tweet, :string, limit: nil
  end
end
