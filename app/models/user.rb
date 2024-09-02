# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, uniqueness: true
  has_many :orders, dependent: :destroy
  has_many :order_items, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_time_password
  enum otp_module: { disabled: 0, enabled: 1 }, _prefix: true
  enum role: { user: 0, admin: 1, moderator: 2 }
  attr_accessor :otp_code_token

  def can_access_admin_views?
    admin? || moderator?
  end
end
