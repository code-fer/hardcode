class CreateVotos < ActiveRecord::Migration[7.2]
  def change
    create_table :votos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :solucion, null: false, foreign_key: true
      t.references :reto, null: false, foreign_key: true

      t.timestamps
    end

    # Índice único en user_id y reto_id para evitar múltiples votos en el mismo reto
    add_index :votos, [:user_id, :reto_id], unique: true
  end
end
