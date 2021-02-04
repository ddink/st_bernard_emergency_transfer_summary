require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PatientsHelper. For example:
#
# describe PatientsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PatientsHelper, type: :helper do
  before do
    @first_user = create(:user, emergency_staff: false)
  end

  describe "show_transfer_summary?" do
    it "should only show the emergency transfer summary"\
       " if current_user has emergency_staff role" do
      create(:user, emergency_staff: true)
      assert_equal helper.show_transfer_summary?, true
    end

    it "should not show the emergency transfer summary"\
       " if the current_user does not have emergency_staff role" do
      assert_equal helper.show_transfer_summary?, false
    end
  end

  describe 'current_user' do
    it 'should provide the first emergency_staff user available' do
      first_emergency_staff_user = create(:user, emergency_staff: true)
      second_emergency_staff_user = create(:user, emergency_staff: true)

      expect(User.count).to eql(3)
      assert helper.current_user != @first_user
      assert helper.current_user != second_emergency_staff_user
      assert_equal helper.current_user, first_emergency_staff_user
    end

    it 'should provide the first user available if no emergency_staff user is available' do
      expect(User.count).to eql(1)
      assert_equal helper.current_user, @first_user
    end
  end
end
