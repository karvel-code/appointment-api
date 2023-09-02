class Patient < User
    has_many :appointments, foreign_key: 'patient_id'
end