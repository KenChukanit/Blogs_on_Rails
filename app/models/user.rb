class User < ApplicationRecord

    has_secure_password

    # validates :email,
    # format: { with: /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/ , message: "Email invalid"  },
    #         uniqueness: { case_sensitive: false },
    #         length: { minimum: 4, maximum: 50 }
end
