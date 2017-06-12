class AdminsitracionUsuarioAddToUnidad < ActiveRecord::Migration
  def change
	  add_column :administracion_usuarios, :unidad_id, :string 
  end
end
