class CreateSolicitudGrupos < ActiveRecord::Migration
  def change
    create_table :solicitud_grupos do |t|

      t.timestamps
    end

    create_table :solicitudesgrupos , id: false do |t|
      t.string   :solicitud_id, index: true
      t.belongs_to :grupo, index: true
    end
  end
end

