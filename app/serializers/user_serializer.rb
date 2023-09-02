class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :type, :first_name, :last_name, :created_at
end
