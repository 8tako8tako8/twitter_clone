# frozen_string_literal: true

if Rails.env.development?
  ApplicationRecord.transaction do
    users = []
    (0..3).each do |i|
      user = User.new(
        email: "user#{i}@example.com",
        password: "password",
        password_confirmation: "password",
        user_name: "User#{i}",
        tel: "0000000000",
        birthdate: "1990-01-01",
        uid: SecureRandom.uuid,
        confirmed_at: Time.now
      )
      file_path = Rails.root.join("db/seeds/user#{i}.png")
      if File.exist?(file_path)
        File.open(file_path) do |file|
          user.image.attach(io: file, filename: "user#{i}.png", content_type: 'image/png')
        end
        file = File.open(file_path)
        user.image.attach(io: file, filename: "user#{i}.png", content_type: 'image/png')
      end
      user.save!
      users << user
    end

    
    # ユーザー0がユーザー1とユーザー2をフォロー
    users[0].follow(users[1])
    users[0].follow(users[2])

    # 各ユーザーが20件のツイートを投稿
    20.times do |i|
      users.each do |user|
        user.tweets.create!(tweet: "#{user.user_name}によるツイートです。")
      end
    end
  end
end

if Rails.env.production?

end