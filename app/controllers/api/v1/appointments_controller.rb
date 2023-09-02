class Api::V1::AppointmentsController < ApplicationController
    before_action :authenticate_user!

    def index
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

    def updated
    end

    def destroy; end

    private
    
    def appointment_params
        params.require(:appointment).permit(:appointment_type, :start_time, :doctor_id)
    end
end
