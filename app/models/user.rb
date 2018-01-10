
class User < ApplicationRecord
  include Authenticable
  include TokenProcessor

  has_many :access_tokens, :dependent => :destroy

  has_attached_file :profile_photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "//s3.us-east-2.amazonaws.com/jonasarguelles/users/profile_photos/default_photo/default-avatar.jpg"
  validates_attachment_content_type :profile_photo,
    content_type: /\Aimage\/.*\z/,
    adapter_options: { hash_digest: Digest::SHA256 }

  attr_accessor :current_token

  validates :email, presence: true
  validates_uniqueness_of :email

  after_create :send_welcome_email

  def self.find_by_credentials(credentials)
   user = self.find_by(email: credentials.fetch(:email, ''))
   user if user.present? && user.valid_password?(credentials.fetch(:password, ''))
  end

  def assign_temporary_password temporary_password
    assign_token :reset_password_token
    self.update_attributes(password: temporary_password, reset_password_token_sent_at: Time.now)
  end

  def reset_password(pw)
    self.update(password: pw, reset_password_token: nil, reset_password_token_sent_at: nil)
  end

  def send_welcome_email
    UserMailer.send_welcome_email(self).deliver_now
  end

  def send_reset_password_email
    UserMailer.send_reset_password_email(self).deliver_now
  end

  private
    def assign_token(attr, scope={})
      loop do
        scope[attr] = SecureRandom.uuid
        next if self.class.exists?(scope)

        assign_attributes(scope)
        break
      end
    end

end
