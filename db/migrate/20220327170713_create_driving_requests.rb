class CreateDrivingRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :driving_requests do |t|
      t.datetime :reservation_datetime, null: false, index: true, precision: 6
      t.string :departure_place, null: false
      t.string :destination, null: false
      t.column :car_model, "enum('普通(AT)', '普通(MT)', '中型', '大型')", null: false
      t.column :status, "enum('代行依頼中', '代行受領済', '依頼完了済')", null: false
      t.integer :receipt_number, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
