class SubscriptionSerializer < ActiveModel::Serializer
  embed :ids, embed_in_root_key: true
  attributes :id
end
