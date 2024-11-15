class AddMoreFieldsToUserData < ActiveRecord::Migration[7.2]
  def change
    add_column :userdata, :tipo, :string
    add_column :userdata, :nombre_apellidos, :string
    add_column :userdata, :ntelefono, :integer
  end
end
