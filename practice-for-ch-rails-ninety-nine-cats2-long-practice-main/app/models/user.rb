class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true 
    validates :password_digest, presence: true
    before_validations :ensure_session_token 

    def find_by_credentials(username, password)
        user_inst = User.find_by(username: username)
        if user_inst && user_inst.correct_password?(password)
             @user_inst
        else
            nil
        end

    end

    attr_reader :password 


    def password=(password)
        self.password_digest = Bcrypt::Password.create(password)
        @password = password
    end


    def correct_password?(password)
        bcypt_obj = Bcrypt::Password.new(self.password_digest)
        bcypt_obj.is_password?(password)
    end


    def reset_session_token!
        Self.session_token = generate_unique_session_token 
        Self.save!
        Self.session_token

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