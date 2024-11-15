class RenameCorreoElectronicoToEmailInUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :correo_electronico, :email
  end
end
