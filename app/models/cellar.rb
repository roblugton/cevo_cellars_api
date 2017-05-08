class Cellar < ApplicationRecord
    has_many :bottles, dependent: :destroy

    validates_presence_of :name
end