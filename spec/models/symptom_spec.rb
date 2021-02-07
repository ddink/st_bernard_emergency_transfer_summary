require 'rails_helper'

RSpec.describe Symptom, type: :model do
  describe "associations" do
    it { should belong_to :admission }
  end

  describe "validations" do
    it { validate_presence_of :description }
  end

  describe "description" do
    it "should show text" do
      symptom = build_stubbed :symptom
      assert_equal symptom.description, "Shooting pain in the leg"
    end
  end
end
