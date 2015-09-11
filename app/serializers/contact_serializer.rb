class ContactSerializer < ActiveModel::Serializer
  embed :ids, embed_in_root_key: true
  attributes :id, :first_name, :last_name, :gender, :relationship
end
