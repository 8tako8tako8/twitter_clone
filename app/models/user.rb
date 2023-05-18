# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable

  validates :tel, presence: true, uniqueness: true
  validates :user_name, presence: true, uniqueness: true
  validates :birthdate, presence: true
end
