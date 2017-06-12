class CreatePlantillas < ActiveRecord::Migration
  def change
    create_table :plantillas do |t|
      t.string :nombre, limit: 30
      t.string :descripcion, limit: 250
      t.boolean :compra # 
      t.integer :tipo # 1 articulo   2 servicio 
      t.timestamps
    end

	create_join_table :plantillas, :articulos do |t|
	  t.string :codemp 
	  t.index :plantilla_id
	  t.string :articulo_id
    end
    add_foreign_key :articulos_plantillas, :plantillas , column: :plantilla_id


	create_join_table :plantillas, :servicios do |t|
	  t.string :codemp 
	  t.index :plantilla_id
	  t.string :servicio_id
    end
  end
end
