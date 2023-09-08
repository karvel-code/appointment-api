require "test_helper"

class AppointmentTest < ActiveSupport::TestCase
  test "should create a valid appointment with permitted attributes" do
    doctor = Doctor.create(email: "doctor@email.com", password: "password")
    patient = Patient.create(email: "patient@email.com", password: "password")
    duration = 30.minutes
    start_time = Timecop.freeze(Time.zone.today.beginning_of_day + 9.hours + 30.years)
    end_time = start_time + duration

    # binding.irb
    appointment = Appointment.new(appointment_type: 'checkup' ,start_time: start_time, end_time: end_time, doctor_id: doctor.id, patient_id: patient.id, status: "pending")
    # binding.irb
    assert appointment.valid?
  end
end
