class Api::V1::MarkAppointmentStatusController < ApplicationController
    before_action :authenticate_user!, :set_appointment

    def update
        # binding.irb
        # authorize @appointment
        if current_user.is_a?(Doctor)
            if @appointment.update(status: mark_appointment_status_params[:status])
                render json: {
                    status: {code: 200, message: "Appointment successfully marked as #{mark_appointment_status_params[:status]}."},
                    data: AppointmentSerializer.new(@appointment).serializable_hash[:data][:attributes]
                }, status: :ok
            else
                render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: "Only Doctors can perform this action", status: :forbidden
        end
    end

    private
    
    def set_appointment
        # @appointment =  Appointment.find(mark_appointment_status_params[:appointment_id])
        @appointment =  Appointment.find(params[:id])
    end

    def mark_appointment_status_params
        params.require(:appointment).permit(:status, :appointment_id)
    end
end
