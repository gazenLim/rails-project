class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :delivery, presence: true

  validates :amount, numericality: {greater_than: 0, message: "must be of some value"}
  validate :expiration_date_cannot_be_in_the_past



  def expiration_date_cannot_be_in_the_past
    if delivery.present? && delivery.past?
      errors.add(:delivery, "Date can't be in the past")
    end
  end 

 

  scope :alpha_order, -> { order(delivery: :asc)}

  def delivery_time_formate
    delivery.strftime('%A, %b %d')
   end

   def created_time
    self.created_at.strftime('%A, %b %d')
   end



  




end
