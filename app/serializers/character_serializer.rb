class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_link, :personality, :level
  has_one :player, serializer: PlayerEssentialsSerializer
end
