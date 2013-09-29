class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :request_id, :null => false, :references => [:requests, :id]
      t.timestamps
    end
  end
end
