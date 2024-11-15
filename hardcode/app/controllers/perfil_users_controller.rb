class PerfilUsersController < ApplicationController
  before_action :authenticate_user!
  def user
      # Access the logged-in user's data
      @userdat = Userdatum.find_by(user_id: current_user.id)
      @user = current_user
      @solucionsUsuario = Solucion.where(user_id: current_user.id)
      # @retosUsuario = Reto.find_by(retos_id: @solucionesUsuario.reto)
  end

  before_action :authenticate_user!
  def misRetos
  end
end
