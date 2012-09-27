module B64UUID
  def self.generate
    uuid = UUID.new.generate.gsub('-', '').scan(/\w{2}/).map{ | each | each.hex }.pack('c' * 16)
    Base64.urlsafe_encode64(uuid).sub(/=+$/, '')
  end
end
