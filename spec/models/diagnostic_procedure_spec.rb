require 'rails_helper'

RSpec.describe DiagnosticProcedure, type: :model do
  describe 'validations' do
    it { should validate_presence_of :description }
  end

  describe "moment" do
    it "should have the same datetime value as diagnostic procedure's created_at attribute" do
      diagnostic_procedure = create :diagnostic_procedure
      assert_equal diagnostic_procedure.moment, diagnostic_procedure.created_at
    end
  end
end
