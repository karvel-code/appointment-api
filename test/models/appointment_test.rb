require "test_helper"

class AppointmentTest < ActiveSupport::TestCase
  test "calculate_end_time for consultation" do
    appointment = appointments(:consultation_appointment)
    appointment.calculate_end_time
    assert_equal Time.parse("2023-09-01 10:20:00"), appointment.end_time
  end
end
