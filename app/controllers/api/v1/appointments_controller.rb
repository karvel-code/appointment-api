class Api::V1::AppointmentsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def create
    end

    def updated
    end

    def destroy; end

    private
    
    def appointment_params
        params.require(:appointment).permit(:appointment_type, :start_time, :doctor_id)
    end
end
