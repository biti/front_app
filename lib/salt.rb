module Salt

  def password= s
    self[:salt] ||= SecureRandom.base64(SALT_LENGTH)
    self[:password] = crypt(s)
  end

  def authenticate s
    self if self[:password] && self[:salt] &&
      self[:password] == crypt(s)
  end

  # ------------------------------------------------------------
  private

  SALT_LENGTH = 6

  def crypt s
    Digest::SHA1.hexdigest(format('%s|%s', s, self[:salt]))
  end

end
