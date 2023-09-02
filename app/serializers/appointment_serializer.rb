class AppointmentSerializer
  include JSONAPI::Serializer
  attributes :id, :appointment_type, :start_time, :end_time, :doctor_id, :patient_id
end
