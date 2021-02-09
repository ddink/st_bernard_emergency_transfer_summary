require 'rails_helper'

RSpec.describe Diagnosis, type: :model do
  describe "associations" do
    it { should belong_to :patient }
    it { should belong_to :admission }
  end

  describe "validations" do
    it { validate_presence_of :description }
  end

  describe "attributes" do
    before do
      @diagnosis = create(:diagnosis)
      @chronic_condition = create(:diagnosis, chronic_condition: true)
    end

    describe "description" do
      it "should show text" do
        assert_equal @diagnosis.description, "Broken Leg"
      end
    end

    describe "chronic_condition" do
      it 'should include attribute' do
        expect(@diagnosis.attributes).to include('chronic_condition')
        expect(@chronic_condition.attributes).to include('chronic_condition')
      end

      it 'should have an chronic_conditions scope for all diagnoses marked as chronic_condition' do
        expect(Diagnosis.chronic_conditions).to include(@chronic_condition)
      end
    end

    describe "regular_diagnoses scope" do
      it 'should return all diagnoses not marked as chronic_condition' do
        expect(Diagnosis.regular_diagnoses).to include(@diagnosis)
      end
    end
  end
end
