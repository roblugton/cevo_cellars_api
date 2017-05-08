class Bottle < ApplicationRecord
  belongs_to :cellar

  validates_presence_of :name, :winery, :vintage
end
