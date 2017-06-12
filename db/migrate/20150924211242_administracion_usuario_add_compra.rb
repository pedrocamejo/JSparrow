class AdministracionUsuarioAddCompra < ActiveRecord::Migration
  def change
  	    add_column :administracion_usuarios, :compra, :boolean, default: false 
  end
end
