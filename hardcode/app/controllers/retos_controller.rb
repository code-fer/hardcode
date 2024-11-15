class RetosController < ApplicationController
  def reto
  end
  before_action :authenticate_user!
  def show

    @reto = Reto.find(params[:id])
    # Verificar si el usuario ha subido una solución para este reto
    @usuario_ha_subido_solucion = Solucion.exists?(user_id: current_user.id, reto_id: @reto.id)
    @voto_dado = Voto.find_by(:user_id => current_user.id, :reto_id => params[:reto_id])


    # Cargar las soluciones del reto, si el usuario ha subido una solución
    if @usuario_ha_subido_solucion
      @soluciones = @reto.solucions
    else
      @soluciones = []  # Si el usuario no ha subido una solución, no mostrar soluciones de otros
    end
  end
  # Método para la página de creación de reto

  def new
    @reto = Reto.new
  end

  # Método para guardar un nuevo reto
  def create
    @reto = Reto.new(reto_params)
    @reto.user_id = current_user.id  # Asocia el reto al usuario que lo crea

    if @reto.save
      redirect_to reto_path(@reto), notice: "¡Reto creado exitosamente!"
    else
      render :new
    end
  end

  private

  # Verifica que el usuario tenga el tipo "creador"
  def check_if_creator
    user_data = Userdatum.find_by(user_id: current_user.id)
    if user_data.nil? || user_data.tipo != "creador"
      redirect_to root_path, alert: "No tienes permisos para crear retos."
    end
  end

  # Filtros para los parámetros del reto
  def reto_params
    params.require(:reto).permit(:nombre, :descripcion, :fuente, :dificultad, :empresa)
  end
end