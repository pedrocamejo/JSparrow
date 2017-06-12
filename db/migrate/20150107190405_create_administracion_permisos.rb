class CreateAdministracionPermisos < ActiveRecord::Migration
  def change
    create_table :administracion_permisos do |t|
      t.string  :nombre
      t.integer :controlador_id
      t.string  :accion
      t.text    :descripcion
      t.timestamps
    end
  end
end
