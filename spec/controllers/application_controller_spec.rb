require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  before do
    @first_user = User.create(emergency_staff: false)
    @first_emergency_staff_user = User.create(emergency_staff: true)
    @second_emergency_staff_user = User.create(emergency_staff: true)
  end

  describe 'current_user' do
    it 'should provide the first emergency_staff user available' do
      expect(User.count).to eql(3)
      expect(controller.send(:current_user)).to_not eql(@first_user)
      expect(controller.send(:current_user)).to_not eql(@second_emergency_staff_user)
      expect(controller.send(:current_user)).to eql(@first_emergency_staff_user)
    end
  end
end
