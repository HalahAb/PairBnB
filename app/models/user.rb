class User < ApplicationRecord
  include Clearance::User

  has_many :authentications, dependent: :destroy
  has_many :listings, foreign_key: :host_id
  has_many :bookings, foreign_key: :guest_id

  mount_uploader :image, ProfileImageUploader

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      name: auth_hash["name"],
      password: SecureRandom.hex(10),
      email: auth_hash["extra"]["raw_info"]["email"]
    )
    user.authentications << authentication
    return user
  end

  # grab fb_token to access Facebook for user data
  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end
end