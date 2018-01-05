class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'Cat'

  has_many :cat_rental_requests

  has_many :session_token_joins

  has_many :sessions,
  through: :session_token_joins,
  source: :session

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    if user
      return user if user.is_password?(password)
    end
    nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    save
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private

  def ensure_session_token
    # new_token = SessionToken.create(token: SecureRandom::urlsafe_base64, environment: )
    self.session_token ||= SecureRandom::urlsafe_base64
  end

end
