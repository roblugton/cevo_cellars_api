class Bottle < ApplicationRecord
  belongs_to :cellar

  validates_presence_of :name, :varietal, :winery, :vintage
end
