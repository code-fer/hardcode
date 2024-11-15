class ApplicationController < ActionController::Base

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Redirige a una ruta específica después del inicio de sesión con Devise
  def after_sign_in_path_for(resource)
    # Cambia `custom_path` por la ruta de tu vista personalizada

    arena_path # o main_dashboard_path o el path que desees
  end

  # Redirige a una ruta específica después del registro con Devise
  def after_sign_up_path_for(resource)
    # Cambia `custom_path` por la ruta de tu vista personalizada
    userdata_path # o main_dashboard_path o el path que desees
  end
end
