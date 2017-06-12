class UsuarioUnidades < ActiveRecord::Migration
  def change
    create_table :usuario_unidades , id: false do |t|
      t.integer :usuario_id
      t.string :unidad_id
    end
  end
end
