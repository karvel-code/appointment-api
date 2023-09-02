class Appointment < ApplicationRecord
    belongs_to :patient, class_name: 'Patient', foreign_key: 'patient_id'
    belongs_to :doctor, class_name: 'Doctor', foreign_key: 'doctor_id'
end
