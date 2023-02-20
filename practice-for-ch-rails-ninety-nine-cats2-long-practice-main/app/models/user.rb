class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true 
    validates :password_digest, presence: true
    before_validations :ensure_session_token 

    attr_reader :password 

    def password=(password)
        self.password_digest = Bcrypt::Password.create(password)
        @password = password
    end

    private 

    def generate_unique_session_token
        token = SecureRandom::urlsafe_base64
        while User.exists?(session_token: token)
            token = SecureRandom::urlsafe_base64
        end

    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token 
    end
end