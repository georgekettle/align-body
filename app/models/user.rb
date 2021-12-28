class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :rememberable, :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable

  has_many :saves, class_name: "Save", foreign_key: "user_id", dependent: :destroy
  has_many :workouts, through: :saves

  pay_customer
  has_person_name

  def active_subscriptions
    subscriptions.where(status: "active")
  end

  def subscribed?
    subscriptions.where(status: "active").present?
  end

  def admin?
    admin
  end
end
