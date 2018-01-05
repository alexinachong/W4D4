class SessionTokenJoin < ApplicationRecord
  validates :user_id, :session_id, presence: true
  validates :session_id, uniqueness: true

  belongs_to :user

  belongs_to :session,
  primary_key: :id,
  foreign_key: :session_id,
  class_name: 'SessionToken'
end
