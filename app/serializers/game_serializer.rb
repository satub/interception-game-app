class GameSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :turn, :winner, :map_name, :map_size
  has_many :locations, serializer: CustomLocationSerializer
end
