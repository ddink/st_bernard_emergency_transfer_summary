require 'rails_helper'

RSpec.describe Treatment, type: :model do
  describe 'validations' do
    it { should validate_presence_of :description }
    it { should validate_presence_of :necessity }
  end
end
