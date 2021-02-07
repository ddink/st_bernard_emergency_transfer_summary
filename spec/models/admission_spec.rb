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

  describe 'diagnoses_description' do
    before do
      @admission.diagnoses << create(:diagnosis, description: "femoral shaft (S95.103A)")
      @admission.diagnoses << create(:diagnosis, description: "femur (S95.105C)")
    end

    it "should clearly describe an individual diagnosis" do
      remove_last_item_in_collection @admission.diagnoses
      expect(@admission.diagnoses_description).to eql "femoral shaft (S95.103A)"
    end

    it "should clearly describe the patient's diagnoses" do
      expect(@admission.diagnoses_description).to eql "femoral shaft (S95.103A) and femur (S95.105C)"
    end
  end

  describe 'symptoms_description' do
    before do
      @admission.symptoms << create(:symptom)
      @admission.symptoms << create(:symptom, description: "his leg is bleeding")
    end

    it "should clearly describe an individual symptom" do
      remove_last_item_in_collection @admission.symptoms
      expect(@admission.symptoms_description).to eql "shooting pain in the leg"
    end

    it "should clearly describe the patient's symptoms" do
      expect(@admission.symptoms_description).to eql "shooting pain in the leg and his leg is bleeding"
    end
  end

  describe 'observations_description' do
    before do
      @admission.observations << create(:observation)
      @admission.observations << create(:observation, description: "no soft tissues were damaged")
    end

    it "should clearly describe an individual observation" do
      remove_last_item_in_collection @admission.observations
      expect(@admission.observations_description).to eql "it appears to be a fracture"
    end

    it "should clearly describe the patient's observations" do
      expect(@admission.observations_description).to eql "it appears to be a fracture and no soft tissues were damaged"
    end
  end

  private

  def remove_last_item_in_collection(collection)
    collection.destroy collection.last
  end
end
