class AddFieldsToUserData < ActiveRecord::Migration[7.2]
  def change
    add_column :userdata, :nombre_usuario, :string
    add_column :userdata, :puntuacion, :integer
    add_column :userdata, :rrss_1, :string
    add_column :userdata, :rrss_2, :string
    add_column :userdata, :rrss_3, :string
  end
end
