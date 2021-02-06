require 'rails_helper'

RSpec.describe DiagnosticProcedure, type: :model do
  before do
    @diagnostic_procedure = create :diagnostic_procedure, created_at: DateTime.new(2021,2,6,11)
  end

  describe 'validations' do
    it { should validate_presence_of :description }
  end

  describe "moment" do
    it "should have the same datetime value as diagnostic procedure's created_at attribute" do
      assert_equal @diagnostic_procedure.moment, @diagnostic_procedure.created_at
    end
  end

  describe "formatted_date" do
    it "should neatly display the date of the patient's admission" do
      expect(@diagnostic_procedure.formatted_date).to eql "February 6, 2021"
    end
  end

  describe "formatted_time" do
    it "should neatly display the time of the patient's admission" do
      expect(@diagnostic_procedure.formatted_time).to eql "11:00 am"
    end
  end
end
