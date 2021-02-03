require 'rails_helper'

RSpec.describe User, type: :model do

  let(:subject) { create(:user, emergency_staff: true) }
  let(:subject2) { create(:user, emergency_staff: true) }

  it 'should include emergency_staff attribute' do
    expect(subject.attributes).to include('emergency_staff')
  end

  it 'should have an emergency_personnel scope for all users with the emergency_staff role' do
    expect(User.emergency_personnel).to include(subject, subject2)
  end
end
