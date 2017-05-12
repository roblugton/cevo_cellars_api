class CellarSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at

  # Model association
  has_many :bottles
end
