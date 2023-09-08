require "test_helper"

class Api::V1::AppointmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Include this for authentication

  def setup
    @doctor = Doctor.create(email: "doctor@email.com", password: "password")
    @patient = Patient.create(email: "patient@email.com", password: "password")
  end

  test "should get index for doctor" do
    sign_in @doctor
    get api_v1_appointments_url, params: { appointment: { start_time: '2023-09-07' } }
    assert_response :success

  end

  test "should not get index for non-doctor" do
    sign_in @patient
    get api_v1_appointments_url, params: { appointment: { start_time: '2023-09-07' } }
    assert_response :forbidden

  end

  test "should create appointment" do
    sign_in @patient
    appointment_params = {
      appointment: {
        appointment_type: 'checkup',
        start_time: Timecop.freeze(Time.now.beginning_of_day + 9.hours + 30.years),
        doctor_id: @doctor.id,
      }
    }

    post api_v1_appointments_url, params: appointment_params
    assert_response :success
  end



end
