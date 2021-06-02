class User < ApplicationRecord
  has_secure_password

  has_many :inventories
    has_many :products, through: :inventories

    validates :username, uniqueness: true 
    validates :username,  presence: true
    validates :email, uniqueness: true
  

    def number_of_orders
    self.inventories.count
    end

 
end
