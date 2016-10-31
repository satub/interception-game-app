class GameSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :turn, :winner, :map_name, :map_size, :background_image_link
  has_many :ordered_locations, serializer: CustomLocationSerializer
  # has_many :locations, serializer: CustomLocationSerializer
  has_many :game_players, serializer: CustomGPSerializer
end
