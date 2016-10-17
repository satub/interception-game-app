class LocationSerializer < ActiveModel::Serializer
  attributes :id, :content, :defense, :controlled_by
  has_one :game
end
