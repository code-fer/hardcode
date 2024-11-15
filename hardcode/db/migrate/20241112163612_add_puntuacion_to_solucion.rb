class AddPuntuacionToSolucion < ActiveRecord::Migration[7.2]
  def change
    add_column :solucions, :puntuacion, :integer
  end
end
