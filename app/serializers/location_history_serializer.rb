class LocationHistorySerializer < ActiveModel::Serializer
  attributes :id, :character_id, :message, :troops_sent, :success
end
