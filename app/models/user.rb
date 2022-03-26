class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable, :rememberable, :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :timeoutable

  has_many :saves, class_name: "Save", foreign_key: "user_id", dependent: :destroy
  has_many :workouts, through: :saves

  pay_customer
  has_person_name

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone, phone: { possible: true, types: [:voip, :mobile] }, presence: true
  validates :terms_of_service, acceptance: true

  after_commit :create_sendgrid_contact, on: :create

  def active_subscriptions
    subscriptions.where(status: "active")
  end

  def subscribed?
    active_subscriptions.any?
  end

  def admin?
    admin
  end

  private

  def create_sendgrid_contact
    CreateSendgridContactJob.perform_later(self)
  end
end
