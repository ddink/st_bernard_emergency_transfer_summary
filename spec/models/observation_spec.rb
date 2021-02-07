require 'rails_helper'

RSpec.describe Observation, type: :model do
  before do
    @observation = create :observation
  end

  describe "associations" do
    it { should belong_to :admission }
  end

  describe "validations" do
    it { validate_presence_of :description }
  end

  describe "description" do
    it "should show text" do
      assert_equal @observation.description, "It appears to be a fracture"
    end
  end

  describe "moment" do
    it "should have the same datetime value as observation's created_at attribute" do
      assert_equal @observation.moment, @observation.created_at
    end
  end
end
