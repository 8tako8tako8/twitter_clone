# frozen_string_literal: true

if Rails.env.development?
  ApplicationRecord.transaction do
    users = []
    4.times do |i|
      user = User.new(
        email: "user#{i}@example.com", password: 'password',
        password_confirmation: 'password', user_name: "User#{i}",
        introduction: '2023年3月〜プログラミング学習中/Ruby,Java,C言語が書けます',
        tel: '0000000000', birthdate: '1990-01-01',
        location: 'Tokyo', website_url: 'test@example.com',
        uid: SecureRandom.uuid, confirmed_at: Time.zone.now
      )
      image_path = Rails.root.join("db/seeds/user#{i}.png")
      if File.exist?(image_path)
        file = File.open(image_path)
        user.image.attach(io: file, filename: "user#{i}.png", content_type: 'image/png')
      end
      if i.zero?
        header_image_path = Rails.root.join('db/seeds/header.jpg')
        if File.exist?(header_image_path)
          file = File.open(header_image_path)
          user.header_image.attach(io: file, filename: 'header.jpg', content_type: 'image/jpeg')
        end
      end
      user.save!
      users << user
    end

    # ユーザー0がユーザー1とユーザー2をフォロー
    users[0].follow(users[1])
    users[0].follow(users[2])

    # 各ユーザーが20件のツイートを投稿
    20.times do |_i|
      users.each do |user|
        user.tweets.create!(tweet: "#{user.user_name}によるツイートです。")
      end
    end

    # ユーザー0がユーザー1のツイートをいいね
    user1_tweets = Tweet.where(user_id: users[1].id)
    user1_tweets.each do |tweet|
      users[0].favorite(tweet)
    end
    # ユーザー0がユーザー2のツイートをリツイート
    user2_tweets = Tweet.where(user_id: users[2].id)
    user2_tweets.each do |tweet|
      users[0].retweet(tweet)
    end
    # ユーザー0がユーザー3のツイートにコメント
    user3_tweets = Tweet.where(user_id: users[3].id)
    user3_tweets.each do |tweet|
      users[0].comment('いいですね！', tweet)
      users[0].comment('最高です！', tweet)
    end

    # ユーザー1がユーザー2のツイートをいいね
    user1_tweets = Tweet.where(user_id: users[2].id)
    user1_tweets.each do |tweet|
      users[1].favorite(tweet)
    end
    # ユーザー1がユーザー3のツイートをリツイート
    user2_tweets = Tweet.where(user_id: users[3].id)
    user2_tweets.each do |tweet|
      users[1].retweet(tweet)
    end
    # ユーザー1がユーザー0のツイートにコメント
    user3_tweets = Tweet.where(user_id: users[0].id)
    user3_tweets.each do |tweet|
      users[1].comment('いいですね！', tweet)
      users[1].comment('最高です！', tweet)
    end

    # ユーザー2がユーザー3のツイートをいいね
    user1_tweets = Tweet.where(user_id: users[3].id)
    user1_tweets.each do |tweet|
      users[2].favorite(tweet)
    end
    # ユーザー2がユーザー0のツイートをリツイート
    user2_tweets = Tweet.where(user_id: users[0].id)
    user2_tweets.each do |tweet|
      users[2].retweet(tweet)
    end
    # ユーザー2がユーザー1のツイートにコメント
    user3_tweets = Tweet.where(user_id: users[1].id)
    user3_tweets.each do |tweet|
      users[2].comment('いいですね！', tweet)
      users[2].comment('最高です！', tweet)
    end

    # ユーザー3がユーザー0のツイートをいいね
    user1_tweets = Tweet.where(user_id: users[0].id)
    user1_tweets.each do |tweet|
      users[3].favorite(tweet)
    end
    # ユーザー3がユーザー1のツイートをリツイート
    user2_tweets = Tweet.where(user_id: users[1].id)
    user2_tweets.each do |tweet|
      users[3].retweet(tweet)
    end
    # ユーザー3がユーザー2のツイートにコメント
    user3_tweets = Tweet.where(user_id: users[2].id)
    user3_tweets.each do |tweet|
      users[3].comment('いいですね！', tweet)
      users[3].comment('最高です！', tweet)
    end
  end
end

if Rails.env.production?
  ApplicationRecord.transaction do
    users = []
    4.times do |i|
      user = User.new(
        email: "user#{i}@example.com", password: 'password',
        password_confirmation: 'password', user_name: "User#{i}",
        introduction: '2023年3月〜プログラミング学習中/Ruby,Java,C言語が書けます',
        tel: '0000000000', birthdate: '1990-01-01',
        location: 'Tokyo', website_url: 'test@example.com',
        uid: SecureRandom.uuid, confirmed_at: Time.zone.now
      )
      image_path = Rails.root.join("db/seeds/user#{i}.png")
      if File.exist?(image_path)
        file = File.open(image_path)
        user.image.attach(io: file, filename: "user#{i}.png", content_type: 'image/png')
      end
      if i.zero?
        header_image_path = Rails.root.join('db/seeds/header.jpg')
        if File.exist?(header_image_path)
          file = File.open(header_image_path)
          user.header_image.attach(io: file, filename: 'header.jpg', content_type: 'image/jpeg')
        end
      end
      user.save!
      users << user
    end

    # ユーザー0がユーザー1とユーザー2をフォロー
    users[0].follow(users[1])
    users[0].follow(users[2])

    # 各ユーザーが20件のツイートを投稿
    20.times do |_i|
      users.each do |user|
        user.tweets.create!(tweet: "#{user.user_name}によるツイートです。")
      end
    end

    # ユーザー0がユーザー1のツイートをいいね
    user1_tweets = Tweet.where(user_id: users[1].id)
    user1_tweets.each do |tweet|
      users[0].favorite(tweet)
    end
    # ユーザー0がユーザー2のツイートをリツイート
    user2_tweets = Tweet.where(user_id: users[2].id)
    user2_tweets.each do |tweet|
      users[0].retweet(tweet)
    end
    # ユーザー0がユーザー3のツイートにコメント
    user3_tweets = Tweet.where(user_id: users[3].id)
    user3_tweets.each do |tweet|
      users[0].comment('いいですね！', tweet)
      users[0].comment('最高です！', tweet)
    end

    # ユーザー1がユーザー2のツイートをいいね
    user1_tweets = Tweet.where(user_id: users[2].id)
    user1_tweets.each do |tweet|
      users[1].favorite(tweet)
    end
    # ユーザー1がユーザー3のツイートをリツイート
    user2_tweets = Tweet.where(user_id: users[3].id)
    user2_tweets.each do |tweet|
      users[1].retweet(tweet)
    end
    # ユーザー1がユーザー0のツイートにコメント
    user3_tweets = Tweet.where(user_id: users[0].id)
    user3_tweets.each do |tweet|
      users[1].comment('いいですね！', tweet)
      users[1].comment('最高です！', tweet)
    end

    # ユーザー2がユーザー3のツイートをいいね
    user1_tweets = Tweet.where(user_id: users[3].id)
    user1_tweets.each do |tweet|
      users[2].favorite(tweet)
    end
    # ユーザー2がユーザー0のツイートをリツイート
    user2_tweets = Tweet.where(user_id: users[0].id)
    user2_tweets.each do |tweet|
      users[2].retweet(tweet)
    end
    # ユーザー2がユーザー1のツイートにコメント
    user3_tweets = Tweet.where(user_id: users[1].id)
    user3_tweets.each do |tweet|
      users[2].comment('いいですね！', tweet)
      users[2].comment('最高です！', tweet)
    end

    # ユーザー3がユーザー0のツイートをいいね
    user1_tweets = Tweet.where(user_id: users[0].id)
    user1_tweets.each do |tweet|
      users[3].favorite(tweet)
    end
    # ユーザー3がユーザー1のツイートをリツイート
    user2_tweets = Tweet.where(user_id: users[1].id)
    user2_tweets.each do |tweet|
      users[3].retweet(tweet)
    end
    # ユーザー3がユーザー2のツイートにコメント
    user3_tweets = Tweet.where(user_id: users[2].id)
    user3_tweets.each do |tweet|
      users[3].comment('いいですね！', tweet)
      users[3].comment('最高です！', tweet)
    end
  end
end
