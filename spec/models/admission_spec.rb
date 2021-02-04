require 'rails_helper'

RSpec.describe Admission, type: :model do
  describe "associations" do
    it { should have_many :diagnoses }
    it { should have_many :symptoms }
    it { should have_many :observations }
    it { should have_one :patient}
    it { should belong_to :facility }
  end

  describe "moment" do
    it "should have the same datetime value as admission's created_at attribute" do
      admission = create(:admission)
      assert_equal admission.moment, admission.created_at
    end
  end
end
