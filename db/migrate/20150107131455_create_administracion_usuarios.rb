class CreateAdministracionUsuarios < ActiveRecord::Migration
  def change
    create_table :administracion_usuarios do |t|

		t.string  :username , limit: 15 , unique: true
		t.string  :cedula  , limit: 10 , unique: true
		t.string  :nombres, :string   , limit: 40   
	    t.string  :apellidos, :string , limit: 40  
	    t.string  :celular , :string  , limit: 15 
	    t.string  :telefono, :string  , limit: 15
	    t.string  :direccion, :string , limit: 250 
	    t.boolean :estado , default: true 
   		t.timestamps
    end
  end
end
