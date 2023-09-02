class Appointment < ApplicationRecord
    STATUS = %w[pending complete cancelled].freeze
    # Validations
    validates :appointment_type, inclusion: { in: %w(consultation checkup) }
    validates :start_time, presence: true
    validates :doctor_id, presence: true
    validates :patient_id, presence: true

    # Custom Validations
    validate :within_time_frame
    validate :availability, on: :create
    # validate :restrict_late_schedule

    # Associations
    belongs_to :patient, class_name: 'Patient', foreign_key: 'patient_id'
    belongs_to :doctor, class_name: 'Doctor', foreign_key: 'doctor_id'

    # Callbacks
    before_validation :calculate_end_time
    after_create :send_appointment_email

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
          errors.add(:base, 'Appointment must be scheduled between 8:00 AM and 5:00 PM')
        end
    end

    def restrict_late_schedule
        if start_time < Time.now
            errors.add(:base, 'Appointment cannot be scheduled after time has passed')
        end
    end

    def availability
        if Appointment.where(doctor: doctor, start_time: start_time..end_time).exists?
          errors.add(:base, 'Doctor is not available at this time')
        end
    end
    
    def send_appointment_email
        AppointmentMailer.appointment_email(self).deliver_later
    end
end
