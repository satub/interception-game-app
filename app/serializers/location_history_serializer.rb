class LocationHistorySerializer < ActiveModel::Serializer
  attributes :id, :character_id, :message, :troops_sent, :success
  has_one :character, serializer: CustomCharacterSerializer
end
