require 'rails_helper'

RSpec.describe OrderFrequency, type: :model do
  describe 'validations' do
    it { should validate_presence_of :value }
    it { should validate_presence_of :unit }
    it { expect(OrderFrequency.units[:hr]).to be 0 }
  end
end
