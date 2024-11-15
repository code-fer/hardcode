class UserdataController < ApplicationController
  before_action :authenticate_user!

  def new
    @user_data = Userdatum.new
  end

  def createcompetidor
    @user_data = Userdatum.new(user_data_params_competidor)
    @user_data.puntuacion=0
    @user_data.tipo="competidor"
    @user_data.user_id = current_user.id # Asigna el ID del usuario actual al campo user_id

    if @user_data.save
      redirect_to root_path, notice: "Datos completados exitosamente"
    else
      render :new, alert: "Hubo un error al guardar los datos"
    end
  end

  def createcreador
  end
  private

  def user_data_params_competidor
    params.require(:userdatum).permit(:nombre_usuario, :rrss_1, :rrss_2, :nombre_apellidos, :ntelefono)
  end
end