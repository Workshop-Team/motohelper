class Maintinance < ApplicationRecord
  belongs_to :car
  validates :name, presence: true
end
