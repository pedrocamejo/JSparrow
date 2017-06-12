class CreateAdministracionGrupoUsuarioJoinTable < ActiveRecord::Migration
  def change
    create_join_table :grupos, :usuarios, table_name: "administracion_grupos_usuarios" do |t|
	   t.index [:grupo_id, :usuario_id],  name: 'index_administracion_grupos_usuarios_grupoid_usuarioid'
    end
    add_foreign_key :administracion_grupos_usuarios, :administracion_grupos , column: 'grupo_id'
    add_foreign_key :administracion_grupos_usuarios, :administracion_usuarios , column: 'usuario_id'

  end
end
