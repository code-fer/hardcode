class AddVotadoPorUserIdToVotos < ActiveRecord::Migration[7.2]
  def change
    add_column :votos, :votado_por_user_id, :integer
  end
end
