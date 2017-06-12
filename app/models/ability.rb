class Ability
  include CanCan::Ability

  def initialize(user)
    user.permisos_todos.each do |permiso|
        can permiso.accion.to_sym, permiso.controlador.subject_class.constantize
    end
  end

end
 