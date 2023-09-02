class Api::V1::MarkAppointmentStatusController < ApplicationController
    before_action :authenticate_user!, :set_appointment

    def create
        if @appointment.update(status: mark_appointment_status_params[:status])
            render json: "Appointment successfully marked as #{mark_appointment_status_params[:status]}", status: :ok
        else
            render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    
    def set_appointment
        @appointment =  Appointment.find(params[:appointment_id])
    end

    def mark_appointment_status_params
        params.require(:appointment).require(:status)
    end
end
