class Doctor < User
    has_many :appointments, foreign_key: 'doctor_id'
end