class CreateAdministracionPermisoUsuarios < ActiveRecord::Migration
  def change
    create_table :administracion_permiso_usuarios do |t|
      t.integer :usuario_id
      t.integer :permiso_id
      t.boolean :estado

      t.timestamps
    end
  end
end
