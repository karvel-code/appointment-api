class Api::V1::AppointmentsController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.is_a?(Doctor)
            appointments = Appointment.where(doctor_id: current_user.id)
            appointments = Appointment.for_selected_date(filter_params[:selected_date]) if filter_params[:selected_date].present?

            render json: {
                status: {code: 200, message: "Appointments for the date #{filter_params[:selected_date]}."},
                data: appointments
            }, status: :ok
        else
            render json: "Only Doctors can perform this action", status: :forbidden
        end
    end

    def create
        @appointment = Appointment.new(appointment_params.merge(patient_id: current_user.id))
        if @appointment.save
            render json: {
                status: {code: 200, message: "Appointment Scheduled sucessfully."},
                data: AppointmentSerializer.new(@appointment).serializable_hash[:data][:attributes]
            }, status: :ok
        else
            render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def updated; end    
    
    def destroy; end

    private
    
    def appointment_params
        params.require(:appointment).permit(:appointment_type, :start_time, :doctor_id, :selected_date)
    end

    def filter_params
        params.require(:appointment).permit(:selected_date)
    end
end
