class WelcomeController < ApplicationController
  def index
  	@usuario = Administracion::Usuario.new
  end
end
