require 'rails_helper'

RSpec.describe Cellar, type: :model do
  # ensure Cellar has a 1:many relation ship with bottles
  it { should have_many(:bottles).dependent(:destroy)}
  it { should validate_presence_of(:name)}
end
