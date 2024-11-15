class SolucionsController < ApplicationController
  def
  end
    super
  end

  before_action :authenticate_user!
  def show
    @voto_dado = Voto.find_by(:user_id => current_user.id, :reto_id => params[:reto_id])
    @reto = Reto.find(params[:reto_id])
    # Verificar si el usuario ha subido una solución para este reto
    @usuario_ha_subido_solucion = Solucion.exists?(user_id: current_user.id, reto_id: @reto.id)
    @solucion = Solucion.find(params[:solucion_id])

      Rails.logger.debug "Solución encontrada: #{@solucion.inspect}"
      if @usuario_ha_subido_solucion
        if File.exist?(@solucion.url)
           @file_content = File.read(@solucion.url)

        else
          @file_content = "El archivo no se encuentra disponible."
        end
      else
        @file_content = "Antes de ver las soluciones de los demas, tienes que subir la tuya."
      end
  end
end

