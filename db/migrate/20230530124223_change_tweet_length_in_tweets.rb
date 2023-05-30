class ChangeTweetLengthInTweets < ActiveRecord::Migration[7.0]
  def change
    change_column :tweets, :tweet, :string, limit: 140
  end
end
