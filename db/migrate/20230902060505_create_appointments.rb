class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :appointment_type, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.references :patient, foreign_key: { to_table: :users }, null: false
      t.references :doctor, foreign_key: { to_table: :users }, null: false 
      t.timestamps
    end
  end
end
