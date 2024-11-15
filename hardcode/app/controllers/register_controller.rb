class RegisterController < ApplicationController
  def new
    @userdata = Userdatum.new
    if params[:type] == "creator"
      render "register_creator/new"
    else
      render "register_user/new"
    end
  end

  def create
    # Usamos "user_params" para filtrar los parámetros
    @user = Userdatum.new(user_params)
    # Inicializa la puntuación a 0 si aún no está asignada
    @user.puntuacion ||= 0

    # Inicializa el tipo según el parámetro pasado en el formulario
    if params[:type] == "creator"
      @user.tipo = "creator"
    else
      @user.tipo = "user"
    end

    # Comprobamos si el nombre de usuario ya existe
    if User.exists?(nombre_usuario: @user.nombre_usuario)
      flash[:alert] = "El nombre de usuario ya está en uso. Por favor, elige otro."
      render :new # Volver al formulario de registro si el nombre de usuario ya existe
    elsif @user.save
      Rails.logger.info "Usuario guardado exitosamente: #{@user.inspect}"
      flash[:notice] = "Usuario registrado exitosamente."
      redirect_to login_path
    else
      Rails.logger.error "Errores al guardar el usuario: #{@user.errors.full_messages.join(', ')}"
      flash.now[:alert] = "Por favor, revisa los errores."
      render :new
    end
  end

  # Filtramos los parámetros que vienen del formulario
  def user_params
    params.require(:user).permit(:nombre_usuario, :tipo, :nombre_apellidos, :puntuacion, :cuenta1_comp, :cuenta2_comp, :ntelefono, :cuenta1_crea, :cuenta2_crea, :cuenta2_crea, :password, :password_confirmation)
  end
end
