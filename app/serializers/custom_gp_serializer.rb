class CustomGPSerializer < ActiveModel::Serializer
  attributes :game_id, :player_id, :creator
end
