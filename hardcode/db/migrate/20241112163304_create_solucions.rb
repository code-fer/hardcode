class CreateSolucions < ActiveRecord::Migration[7.2]
  def change
    create_table :solucions do |t|
      t.string :url
      t.text :descripcion
      t.references :user, null: false, foreign_key: true
      t.references :reto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
