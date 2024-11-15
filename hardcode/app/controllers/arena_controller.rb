class ArenaController < ApplicationController
  before_action :authenticate_user!
  def arena
    #Recuperamos todos los retos de la BD (CAMBIAR a recomendados para el usuario)
    @retos_recomendados=Reto.all

    #Recuperamos los 10 usuarios con mejor puntuacion
    @usuarios_top=Userdatum.order(puntuacion: :desc).limit(10)
  end
end
