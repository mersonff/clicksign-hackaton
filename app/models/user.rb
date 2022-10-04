class User < ApplicationRecord

  has_secure_password

  api_guard_associations refresh_token: 'refresh_tokens'
  has_many :refresh_tokens, dependent: :delete_all

  api_guard_associations blacklisted_token: 'blacklisted_tokens'
  has_many :blacklisted_tokens, dependent: :delete_all

  api_guard_associations refresh_token: 'refresh_tokens',
    blacklisted_token: 'blacklisted_tokens'

  # If we need to add custom properties to the token, override method below
  def jwt_token_payload
    {}
  end
end
