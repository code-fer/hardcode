class CreateRetos < ActiveRecord::Migration[7.2]
  def change
    create_table :retos do |t|
      t.string :nombre
      t.text :descripcion
      t.string :fuente
      t.integer :dificultad
      t.string :empresa

      t.timestamps
    end
  end
end
