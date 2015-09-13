class OccasionSerializer < ActiveModel::Serializer
  embed :ids, embed_in_root_key: true
  attributes :id, :label, :date
  has_one :contact
end
