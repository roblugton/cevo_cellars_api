require 'rails_helper'

RSpec.describe Bottle, type: :model do
  it { should belong_to(:cellar) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:winery) }
  it { should validate_presence_of(:vintage) }
end
