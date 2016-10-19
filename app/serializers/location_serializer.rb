class LocationSerializer < ActiveModel::Serializer
  attributes :id, :content, :defense, :controlled_by
  has_one :game
  has_many :character_locations, serializer: LocationHistorySerializer
end
