class Appointment < ApplicationRecord
    # Validations
    validates :appointment_type, inclusion: { in: appointment_types.keys }
    validates :start_time, presence: true
    validates :doctor_id, presence: true

    # Custom Validations
    validate :within_time_frame

    # Associations
    belongs_to :patient, class_name: 'Patient', foreign_key: 'patient_id'
    belongs_to :doctor, class_name: 'Doctor', foreign_key: 'doctor_id'

    # Callbacks
    before_create :calculate_end_time

    enum appointment_type: {
        consultation: 'consultation',
        checkup: 'checkup',
    }

    def calculate_end_time
        if appointment_type == "consultation"
          self.end_time = start_time + 20.minutes
        elsif appointment_type == "checkup"
          self.end_time = start_time + 30.minutes
        end 
    end

    def within_time_frame
        unless start_time.between?('8:00 AM'.to_time, '5:00 PM'.to_time) && end_time.between?('8:00 AM'.to_time, '5:00 PM'.to_time)
          errors.add(:start_time, 'Appointment must be scheduled between 8:00 AM and 5:00 PM')
        end
    end
end
