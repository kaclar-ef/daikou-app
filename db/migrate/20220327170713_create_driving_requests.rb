class CreateDrivingRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :driving_requests do |t|

      t.timestamps
    end
  end
end
