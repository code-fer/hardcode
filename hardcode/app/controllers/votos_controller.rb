class VotosController < ApplicationController

  def create
    # Encuentra el usuario creador de la solución
    @solucion = Solucion.find(params[:solucion_id])
    @creador = @solucion.user

    # Verifica que el usuario no pueda votar su propia solución
    if @creador.id != current_user.id
      # Crear el voto

      @voto = Voto.new(user_id: @creador.id, solucion_id: @solucion.id, votado_por_user_id: current_user.id, reto_id: @solucion.reto_id)
      Rails.logger.debug "Voto creado: #{@voto.inspect}"
      if @voto.save
        # Si el voto se guarda correctamente, actualiza las puntuaciones

        @puntuacion_total_creador = Voto.where(user_id: @creador.id).count
        @puntuacion_en_reto = Voto.where(user_id: @creador.id, solucion_id: @solucion.id).count

        # Encuentra el userdatum y la solución para actualizar las puntuaciones
        @user_creador_data = Userdatum.find_by(user_id: @creador.id)
        @sol_votada = @solucion

        # Actualiza las puntuaciones si los registros existen
        if @user_creador_data && @sol_votada
          @user_creador_data.update(puntuacion: @puntuacion_total_creador)
          @sol_votada.update(puntuacion: @puntuacion_en_reto)
        end

        # Redirecciona con un mensaje de éxito
        redirect_to arena_path, notice: "Voto registrado correctamente."
      else
        # Si hay un error al guardar el voto, redirecciona con un mensaje de error
        redirect_to arena_path, alert: "Hubo un error al registrar el voto."
      end
    else
      # Si el usuario intenta votar en su propia solución, redirige con un mensaje de advertencia
      redirect_to arena_path, alert: "No puedes votar tu propia solución."
    end
  end

end
