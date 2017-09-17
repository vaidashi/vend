class Machine < ApplicationRecord
  belongs_to :owner
  has_many :machine_snacks
  has_many :snacks, through: :machine_snacks


  def average_snack_price
    snacks.average(:price).to_f
  end
end
