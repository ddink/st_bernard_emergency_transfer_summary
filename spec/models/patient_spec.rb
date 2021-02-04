require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'associations' do
    it { should have_one :admission }
    it { should have_many :allergies }
    it { should have_many :chronic_conditions }
    it { should have_many :medications }
    it { should have_many :diagnostic_procedures }
    it { should have_many :diagnoses }
    it { should have_many :treatments }
  end

  describe 'validations' do
    let(:gender) { [:male, :female, :other] }

    it { should validate_presence_of :medical_record }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :middle_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :gender }
    it { should validate_numericality_of(:medical_record)
             .only_integer
             .is_greater_than_or_equal_to(10000)
             .is_less_than_or_equal_to(99999) }
    it "has the right values for gender enum" do
      gender.each_with_index do |item, index|
        assert_equal Patient.genders[item], index
      end
    end
  end

  describe 'attributes' do
    it { should allow_value(30997).for(:medical_record) }
    it { should allow_value('John').for(:first_name) }
    it { should allow_value('Q.').for(:middle_name) }
    it { should allow_value('Doe').for(:last_name) }
    it { should allow_value(21.years.ago).for(:dob) }
    it { should allow_value('male').for(:gender) }
  end
end
