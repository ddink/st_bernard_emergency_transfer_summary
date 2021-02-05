require 'rails_helper'

RSpec.describe OrderFrequency, type: :model do
  describe 'validations' do
    it { should validate_presence_of :value }
    it { should validate_presence_of :unit }

    it { assert_equal OrderFrequency.units[:hour], 0 }
  end
end
