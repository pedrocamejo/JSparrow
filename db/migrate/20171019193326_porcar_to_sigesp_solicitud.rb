class PorcarToSigespSolicitud < ActiveRecord::Migration
  def change
	  add_column "public.sep_solicitud", :porcar, :integer 
  end
end
 