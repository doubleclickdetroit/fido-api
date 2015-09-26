class SubscriptionSerializer < ActiveModel::Serializer
  embed :ids, embed_in_root_key: true
  attributes :id, :current_period_start, :current_period_end
end
