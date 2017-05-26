class User < ApplicationRecord
  attr_accessor :remember_token
	before_save { email.downcase! }
	VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :name, presence: true, length: {maximum: 50}
	validates :email, presence: true, length: {maximum: 140},
	                  format: { with: VALID_EMAIL_REGEX},
	                  uniqueness: { case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

  def self.digest(string) #ko hieu no lam nhu nao ca -_-
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64 #random mot ma token
  end

  def remember
    self.remember_token = User.new_token #gan cho chinh use (self de no ko phai la bien cuc bo ma la chinh no) mot ma ngau nhien
    update_attribute(:remember_digest, User.digest(remember_token)) #update thuoc tinh remember_digest bang cai da tao o tren
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)#xac nhan xem 2 ma co giong nhau khong
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
