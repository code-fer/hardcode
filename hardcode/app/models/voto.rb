class Voto < ApplicationRecord
  validates :user_id, :solucion_id, :votado_por_user_id, presence: true
  belongs_to :user
  belongs_to :solucion
end
