class CreateAdministracionControladors < ActiveRecord::Migration
  def change
    create_table :administracion_controladors do |t|
      t.string :subject_class
      t.text :descripcion

      t.timestamps
    end
  end
end
