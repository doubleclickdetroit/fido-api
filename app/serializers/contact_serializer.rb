class ContactSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :gender, :relationship
end
