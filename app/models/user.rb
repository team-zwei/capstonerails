# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)
#  password_digest        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  username               :string(255)
#  auth_token             :string(255)
#  admin                  :boolean
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  firstname              :string(255)
#  lastname               :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation, :firstname, :lastname, :phonenumber
  has_secure_password

  has_many :bids
  has_many :payments
  has_many :payment_methods
  has_many :auctions, through: :bids, uniq: true

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,    presence: true, uniqueness: { case_sensitive: false }, format: { with: valid_email_regex }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def make_admin
    self.update_attribute(:admin, true)
  end

  def send_password_reset
    generate_token :password_reset_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
end
