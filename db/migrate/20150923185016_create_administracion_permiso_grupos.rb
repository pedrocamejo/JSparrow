class CreateAdministracionPermisoGrupos < ActiveRecord::Migration
  def change
    create_table :administracion_permiso_grupos do |t|
      t.belongs_to :permiso, index: true
      t.belongs_to :grupo, index: true
      t.boolean :estado ,default: true

      t.timestamps
    end
  end
end
