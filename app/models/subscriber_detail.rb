class SubscriberDetail < ActiveRecord::Base
  belongs_to :subscriber
  # belongs_to :rank

  def payment_password= s
    self[:payment_salt] ||= SecureRandom.base64(SALT_LENGTH)
    self[:payment_password] = crypt(s)
  end

  def payment_authenticate s
    self if self[:payment_password] && self[:payment_salt] &&
      self[:payment_password] == crypt(s)
  end

  # ------------------------------------------------------------
  private

  SALT_LENGTH = 6

  def crypt s
    Digest::SHA1.hexdigest(format('%s|%s', s, self[:payment_salt]))
  end

end
