require 'rails_helper'

RSpec.describe Admission, type: :model do
  before do
    @admission = create :admission, moment: DateTime.new(2021,2,6,11)
  end

  describe "associations" do
    it { should have_many :diagnoses }
    it { should have_many :symptoms }
    it { should have_many :observations }
    it { should belong_to :patient }
    it { should belong_to :facility }
  end

  describe "moment" do
    it "should have the same datetime value as admission's created_at attribute" do
      assert_equal @admission.moment, @admission.created_at
    end
  end

  describe "formatted_date" do
    it "should neatly display the date of the patient's admission" do
      expect(@admission.formatted_date).to eql "February 6, 2021"
    end
  end

  describe "formatted_time" do
    it "should neatly display the time of the patient's admission" do
      expect(@admission.formatted_time).to eql "11:00 am"
    end
  end

  describe 'diagnosis_description' do
    before do
      @admission.diagnoses << create(:diagnosis, description: "femoral shaft (S95.103A)")
      @admission.diagnoses << create(:diagnosis, description: "femur (S95.105C)")
    end

    it "should clearly describe an individual diagnosis" do
      @admission.diagnoses.destroy @admission.diagnoses.last
      expect(@admission.diagnosis_description).to eql "femoral shaft (S95.103A)"
    end

    it "should clearly describe the patient's diagnoses" do
      expect(@admission.diagnosis_description).to eql "femoral shaft (S95.103A) and femur (S95.105C)"
    end
  end
end
