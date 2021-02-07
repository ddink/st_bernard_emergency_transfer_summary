require 'rails_helper'

RSpec.describe Patient, type: :model do


  describe 'associations' do
    it { should have_one :admission }
    it { should have_one(:facility).through(:admission) }

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

  describe 'methods' do
    before do
      moment_of_admission = DateTime.new(2021, 2,6,11)
      diagnosis1 = create(:diagnosis, description: 'right tibia (S82.101A)')
      diagnosis2 = create(:diagnosis, description: 'fibula (S82.102B)')
      @patient = create(:patient,
                        allergies: [create(:allergy, description: "hypersensitivity to aspirin or NSAIDS"),
                                    create(:allergy, description: "gluten intolerance")],
                        chronic_conditions: [create(:diagnosis, description: "Asthma (J45)"),
                                             create(:diagnosis, description: "Pulmonary Disease (CPOD)")],
                        medications: [create(:medication_order,
                                             name: 'Acetaminophen',
                                             dosage: '500',
                                             necessity: 'relieve pain',
                                             frequency: create(:order_frequency, value: 'q4',)),
                                      create(:medication_order,
                                             name: 'Naproxen',
                                             medication_route: :IM,
                                             dosage: '500',
                                             necessity: 'relieve swelling',
                                             frequency: create(:order_frequency, value: 'q6'))],
                        diagnostic_procedures: [create(:diagnostic_procedure,
                                                       description: 'an exploratory radiography',
                                                       created_at: moment_of_admission),
                                                create(:diagnostic_procedure,
                                                       description: 'an ultrasound',
                                                       created_at: moment_of_admission + 90.minutes)],
                        diagnoses: [diagnosis1, diagnosis2],
                        treatments: [create(:treatment,
                                            description: 'temporary bracing',
                                            necessity: 'restrict the motion'),
                                     create(:treatment,
                                            description: 'triage for transport to hospital',
                                            necessity: 'receive urgent care')])
      create(:admission,
             patient: @patient,
             facility: create(:facility),
             observations: [create(:observation, description: 'no soft tissues were damaged'),
                            create(:observation, description: 'and appears to be a fracture')],
             diagnoses: [diagnosis1, diagnosis2],
             created_at: moment_of_admission)
    end

    describe 'transfer_summary' do
      it "should display summary based on outlined template for summary section" do
        expect(@patient.emergency_transfer_summary).to eql spec_summary
      end
    end

    describe 'age' do
      it { assert_equal @patient.age, "21" }
    end

    describe 'allergies_description' do
      it "should clearly describe an individual allergy" do
        remove_last_item_in_collection @patient.allergies
        expect(@patient.allergies_description).to eql "hypersensitivity to aspirin or NSAIDS"
      end

      it "should clearly describe multiple allergies" do
        expect(@patient.allergies_description).to eql "hypersensitivity to aspirin or NSAIDS and gluten intolerance"
      end
    end

    describe 'chronic_conditions_description' do
      it "should clearly describe an individual chronic condition" do
        remove_last_item_in_collection @patient.chronic_conditions
        expect(@patient.chronic_conditions_description).to eql "Asthma (J45)"
      end

      it "should clearly describe multiple chronic conditions" do
        expect(@patient.chronic_conditions_description).to eql "Asthma (J45) and Pulmonary Disease (CPOD)"
      end
    end

    describe 'medication_administered' do
      it "should clearly describe an individual medication administered to the patient" do
        remove_last_item_in_collection @patient.medications
        expect(@patient.medication_administered).to eql "Acetaminophen 500mg PO q4hr to relieve pain"
      end

      it "should clearly describe multiple medications administered to the patient" do
        expect(@patient.medication_administered).to eql "Acetaminophen 500mg PO q4hr to relieve pain, "\
                                                      "and Naproxen 500mg IM q6hr to relieve swelling"
      end
    end

    describe 'procedure_description' do
      it "should clearly describe an individual diagnosis procedure" do
        remove_last_item_in_collection @patient.diagnostic_procedures
        expect(@patient.procedure_description).to eql "an exploratory radiography on February 6, 2021 at 11:00 am"
      end

      it "should clearly describe multiple diagnosis procedures" do
        expect(@patient.procedure_description).to eql "an exploratory radiography on February 6, 2021 at 11:00 am, "\
                                                    "and an ultrasound on February 6, 2021 at 12:30 pm"
      end
    end

    describe 'diagnoses_description' do
      it "should clearly describe an individual diagnosis" do
        remove_last_item_in_collection @patient.diagnoses
        expect(@patient.diagnoses_description).to eql "right tibia (S82.101A)"
      end

      it "should clearly describe the patient's diagnoses" do
        expect(@patient.diagnoses_description).to eql "right tibia (S82.101A) and fibula (S82.102B)"
      end
    end

    describe 'treatments_description' do
      it "should clearly display an individual treatment" do
        remove_last_item_in_collection @patient.treatments
        expect(@patient.treatments_description).to eql "to temporary bracing to restrict the motion"
      end

      it "should clearly display individual or multiple treatments" do
        expect(@patient.treatments_description).to eql "to temporary bracing to restrict the motion and "\
                                                    "to triage for transport to hospital to receive urgent care"
      end
    end
  end

  private

  def spec_summary
    "This #{@patient.age} years old #{@patient.gender} was admitted to #{@patient.facility.name} "\
    "emergency facility on #{@patient.admission.formatted_date} at #{@patient.admission.formatted_time} "\
    "due to #{@patient.admission.diagnoses_description}. The observed symptoms on admission "\
    "were #{@patient.admission.symptoms}. #{@patient.admission.observations}."

    "Upon asking about known allergies, the patient disclosed #{@patient.allergies_description}. "\
    "Upon asking about chronic conditions, the patient disclosed #{@patient.chronic_conditions_description}. "\
    "The patient was administered with #{@patient.medication_administered}."

    "The staff performed #{@patient.procedure_description}, revealing #{@patient.diagnoses_description}. "\
    "Our team proceeded to #{@patient.treatments_description}"
  end

  def remove_last_item_in_collection(collection)
    collection.destroy collection.last
  end
end
