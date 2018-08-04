class User < ApplicationRecord
  validates_presence_of :name, :email, :role_id
  validates :email, uniqueness: true

  has_secure_password

  belongs_to :role

  def generate_password_token!
    self.reset_password_token = generate_token
    #reset password token expires in 1 hour
    self.reset_password_expires = Time.now + 3600
    save!
  end

  def password_token_valid?
    self.reset_password_expires.future?
  end

  def reset_password!
    self.reset_password_token = nil
    self.password = password
    save!
  end

  private

  def generate_token
    SecureRandom.hex(16)
  end
end
