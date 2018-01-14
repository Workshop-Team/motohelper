# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cars, dependent: :destroy
  has_many :maintenances, -> { includes(:car) }, through: :cars
  has_many :reminders, -> { includes(:car) }, through: :cars
  has_many :mileages, -> { includes(:car) }, through: :cars

  enum language: { pl: 0, en: 1 }

  validates :name, presence: true
  validates :email, uniqueness: true

  def admin?
    type == 'AdminUser'
  end
end
