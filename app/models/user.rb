class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :flats
  has_many :bookings
  has_one_attached :photo

  validates :first_name, :last_name, :telephone, :email, :photo, presence: true
  validates :email, uniqueness: true

  after_create :confirm_user

  def confirm_user
    self.confirm
  end
end
