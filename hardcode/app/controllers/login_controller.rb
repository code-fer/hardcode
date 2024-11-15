class LoginController < ApplicationController

  def new

  end
  def create
    # Find the user by username
    user = User.find_by(nombre_usuario: params[:nombre_usuario])

    # Check if user exists and password is correct
    if user&.authenticate(params[:password])
      # Store user ID in the session to keep them logged in
      session[:user_id] = user.id
      session[:username] = user.nombre_usuario

      redirect_to perfil_user_path, notice: "Bienvenido, #{user.nombre_usuario}!"
    else
      flash.now[:alert] = "Nombre de usuario o contraseña incorrectos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Cierra la sesión
    sign_out current_user # Esto cierra la sesión en Devise
    redirect_to root_path, notice: "Sesión cerrada correctamente"
  end
end
