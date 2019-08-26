# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :audit_logs, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, length: { is: 10 }
  validates :phone, numericality: { only_integer: true }

  def full_name
    "#{first_name} #{last_name}"
  end

  def employee?
    type == "EmployeeUser"
  end

  def admin?
    type == "AdminUser"
  end
end
