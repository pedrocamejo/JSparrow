require 'pg'
class Administracion::Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
   self.primary_key = :id
   has_many  :permiso_usuarios,
    class_name: "Administracion::PermisoUsuario"

   has_many  :permisos,
    through: :permiso_usuarios,
    class_name: "Administracion::Permiso"
   
   has_and_belongs_to_many :unidades,
    :class_name => "Public::SpgMinisterioUa",
    :join_table => "usuario_unidades",
    :foreign_key => "usuario_id",
    :association_foreign_key => "unidad_id"

   belongs_to :unidad, class_name: "Public::SpgMinisterioUa", foreign_key: :unidad_id

   has_and_belongs_to_many :grupos


  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end


  def self.search(page = 1 , search , sort)
    search ||= ""
    sort ||= "" 
    sort = "username" if sort == "UserName"
    sort = "cedula" if sort == "Cedula"
    sort = "nombres" if sort == "Nombres"
    sort = "apellidos" if sort == "Apellidos"

    if search.empty? 
      paginate(page: page).order(sort) rescue paginate(page: 1) 
    else
      paginate(page: page).where("#{sort} like ?","%#{search}%").order("#{sort} asc")
    end 
  end 
  
  def self.get_usuario(cedula)
    usuario = where("cedula like '%#{cedula}%'").first
  end 



  def permisos_todos 
    permisostodos = []
    permisostodos += permisos.eager_load(:controlador)
    grupos.each do |grupo|
      permisostodos += grupo.permisos.eager_load(:controlador)    
    end
    permisostodos 
  end 

 
  ######################### Validacion ##############################################

  validates :username , 
      presence: {message: ' Ingrese un username '},
      uniqueness: {message: 'ya Registrado', on: :create },
      length: {maximum: 15 , too_long:"%{count} caracteres es el maximo  "}

  validates :email, 
         presence: {message: 'Ingrese su Email '},
         format:{ with:/.+@+[a-z]+./ , message: "Formato Invalido"}

 
  validates :cedula, 
      presence: {message: 'Ingrese su Cedula '},
      uniqueness: {message: 'Cedula Registrada', on: :create },
      length: {maximum: 15 , too_long:"%{count} caracteres es el maximo  "},
      format: { with: /V-\d/, message: "Formato Invalido"}

  validates :nombres,
      presence: {message: 'Ingrese Su Nombre '},
      length: {maximum: 40, too_long:"%{count} caracteres es el maximo  "}

  validates :apellidos,
      presence: {message: 'Ingrese Su apellido '},
      length: {maximum: 40, too_long:"%{count} caracteres es el maximo  "}

  validates :celular,
      length: {maximum: 15, too_long:"%{count} caracteres es el maximo  "}

  validates :telefono,
      length: {maximum: 15, too_long:"%{count} caracteres es el maximo  "}

  validates :direccion,
      length: {maximum: 250, too_long:"%{count} caracteres es el maximo  "}
      

  self.per_page = 10 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
