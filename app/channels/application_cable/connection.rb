module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :anonymous_user

    def connect
      self.anonymous_user = SecureRandom.hex(10)
    end
  end
end

