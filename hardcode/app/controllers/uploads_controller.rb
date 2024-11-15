class UploadsController < ApplicationController
  #Pagina para el formulario de subida de archivos
  def new
    @reto = Reto.find(params[:id])
  end
  before_action :authenticate_user!
  def create
    #El reto al que pertenece la solucion nos lo pasan por parametros
    reto = Reto.find(params[:id])

    #Definimos la ruta donde se van a almacenar los archivos

    base_directory = Rails.root.join('solutions_archive', "solutions_of_#{reto.id}")
    user_directory = base_directory.join(current_user.email)

    # Elimina el directorio del usuario si ya existe
    if Dir.exist?(user_directory)
      FileUtils.rm_rf(user_directory)
    end

    # Crea un nuevo directorio para el usuario
    FileUtils.mkdir_p(user_directory)

    # Define el usuario y el directorio donde se guardarán los archivos
  # Procesa el archivo cargado
  if params[:file].present?
    file = params[:file]

    # Verifica que el archivo sea de tipo .txt
    if valid_txt_file?(file)
      #Renombramos el archivo a nombre estandarizado
      # creamos el path (url)

      file_path = user_directory.join("#{reto.id}_#{current_user.id}_solution.txt")
      File.open(file_path, "wb") { |f| f.write(file.read) }
      Rails.logger.debug "Parametros antes de guardar:[ #{current_user} ]"
      # Guarda la Solucion en la base de datos, incluyendo la URL del archivo
      Solucion.create!(
        url: file_path,
        user:current_user, #HACER QUE SEA UN USER
        reto: reto,
        descripcion: params[:descripcion],
        puntuacion: 0
      )

      flash[:notice] = "Archivo subido correctamente."
    else
      flash[:alert] = "Solo se permiten archivos .txt."
    end
  else
    flash[:alert] = "No se seleccionó ningún archivo."
  end
    #volvemos a la pagina del reto
    redirect_to reto_show_path(reto)
  end

  private

  def valid_txt_file?(file)
    File.extname(file.original_filename).downcase == ".txt"
  end

end
