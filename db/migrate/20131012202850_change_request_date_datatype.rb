class ChangeRequestDateDatatype < ActiveRecord::Migration
  def change
  	change_column :requests, :date, :date
  end
end
