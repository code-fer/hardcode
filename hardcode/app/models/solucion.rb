class Solucion < ApplicationRecord
  belongs_to :user
  belongs_to :reto
  has_many :votos
end
