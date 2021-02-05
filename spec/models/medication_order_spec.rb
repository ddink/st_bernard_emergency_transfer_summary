require 'rails_helper'

RSpec.describe MedicationOrder, type: :model do
  describe 'associations' do
    it { should have_one :frequency }
  end

  describe 'validations' do
    let(:mass_unit) { [:mg] }
    let(:medication_route) { [:PO,:IM, :SC] }

    it { should validate_presence_of :name }
    it { should validate_presence_of :mass_unit }
    it { should validate_presence_of :dosage }
    it { should validate_presence_of :frequency }

    it "has the right values for mass_unit enum" do
      mass_unit.each_with_index do |item, index|
        assert_equal MedicationOrder.unit[item], index
      end
    end

    it "has the right values for medication_route enum" do
      medication_route.each_with_index do |item, index|
        assert_equal MedicationOrder.route[item], index
      end
    end
  end


end
