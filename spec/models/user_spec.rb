require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user, emergency_staff: nil) }

  it 'should include emergency_staff attribute' do
    expect(subject.attributes).to include('emergency_staff')
  end
end
