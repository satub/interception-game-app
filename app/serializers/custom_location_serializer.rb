class CustomLocationSerializer < ActiveModel::Serializer
  attributes :id, :content, :defense, :controlled_by
end
