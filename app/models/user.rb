class User < ApplicationRecord
    validates_presence_of :email, :password
    validates_uniqueness_of :email

    
    def self.authenticate(args={})
        self.where(email: args[:email], password: args[:password]).empty? ? false: true 
    end


end
