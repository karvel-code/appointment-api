class AppointmentMailer < ApplicationMailer
    default from: 'appointmentapp@email.com'

    def appointment_email(appointment)
      @appointment = appointment
      @patient = appointment.patient
      mail(to: @patient.email, subject: 'You Appointment has been Scheduled!')
    end
end
