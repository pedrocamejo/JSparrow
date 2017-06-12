class CreateAdministracionGrupos < ActiveRecord::Migration
  def change
    create_table :administracion_grupos do |t|
      t.string :nombre, limit: 30
      t.boolean :estado

      t.timestamps
    end
  end
end
