class Post < ApplicationRecord
    belongs_to :user
    validates :post, length: { minimum: 50, maximum: 255 }
    enum status: { public_status: 0 , private_status: 1 }
end
