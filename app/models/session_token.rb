class SessionToken < ApplicationRecord
  validates :token, :environment, presence: true
  validates :token, uniqueness: true

  has_one :session_token_join,
  primary_key: :id,
  foreign_key: :session_id,
  class_name: 'SessionTokenJoin'

  has_one :user,
  through: :session_token_join,
  source: :user

  def delete_session_token!
    session_token_join.destroy
    destroy
  end
end
