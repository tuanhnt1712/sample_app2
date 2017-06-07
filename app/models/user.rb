class User < ApplicationRecord
  has_many :microposts, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token #???
	before_save :downcase_email
  before_create :create_activation_digest
	VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :name, presence: true, length: {maximum: 50}
	validates :email, presence: true, length: {maximum: 140},
	                  format: { with: VALID_EMAIL_REGEX},
	                  uniqueness: { case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

  def self.digest(string) #chinh lai do dai cua chuoi digest
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token #tao ra mot ma token
    SecureRandom.urlsafe_base64 #random mot ma token
  end

  def remember #update ma token vua tao vao database
    self.remember_token = User.new_token #gan cho chinh use (self de no ko phai la bien cuc bo ma la chinh no) mot ma ngau nhien
    update_attribute(:remember_digest, User.digest(remember_token)) #update thuoc tinh remember_digest bang cai da tao o tren
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)#xac nhan xem 2 ma cua nguoi dung va ma khi duoc gui len serve co giong nhau ko
  end

  def forget
    update_attribute(:remember_digest, nil) #dat ma remember_digest = null
  end

  def downcase_email
    self.email.downcase!
  end

  def create_reset_digest #set password reset attribute
     self.reset_token = User.new_token
     update_attribute(:reset_digest, User.digest(reset_token))
     update_attribute(:reset_send_at, Time.zone.now)
  end

  def send_password_reset_email #send password reset email
    UserMailer.password_reset(self).deliver_now
  end

  def feed
    Micropost.all
  end

  private
  
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
