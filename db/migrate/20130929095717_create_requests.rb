class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id, :null => false, :references => [:users, :id]
      t.time :date
      t.timestamps
    end
  end
end
