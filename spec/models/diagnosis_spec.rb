require 'rails_helper'

RSpec.describe Diagnosis, type: :model do
  describe "associations" do
    it { should belong_to :patient }
    it { should belong_to :admission }
  end

  describe "validations" do
    it { validate_presence_of :description }
  end

  describe "description" do
    it "should show text" do
      diagnosis = build_stubbed :diagnosis
      assert_equal diagnosis.description, "Broken Leg"
    end
  end
end
