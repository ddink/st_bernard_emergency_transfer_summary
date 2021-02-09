require 'rails_helper'

RSpec.describe Patient, type: :model do


  describe 'associations' do
    it { should have_one :admission }
    it { should have_one(:facility).through(:admission) }

    it { should have_many :allergies }
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
      @diagnosis1 = create(:diagnosis, description: 'right tibia (S82.101A)')
      @diagnosis2 = create(:diagnosis, description: 'fibula (S82.102B)')
      @chronic_condition1 = create(:diagnosis, description: "Asthma (J45)", chronic_condition: true)
      @chronic_condition2 = create(:diagnosis, description: "Pulmonary Disease (CPOD)", chronic_condition: true)
      @facility = create(:facility)
      @patient = create(:patient,
                        allergies: [create(:allergy, description: "hypersensitivity to aspirin or NSAIDS"),
                                    create(:allergy, description: "gluten intolerance")],
                        medications: [create(:medication_order,
                                             name: 'Acetaminophen',
                                             dosage: '500',
                                             necessity: 'relieve pain',
                                             frequency: create(:order_frequency, value: 'q4')),
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
                        diagnoses: [@diagnosis1,
                                    @diagnosis2,
                                    @chronic_condition1,
                                    @chronic_condition2],
                        treatments: [create(:treatment,
                                            description: 'temporary bracing',
                                            necessity: 'restrict the motion'),
                                     create(:treatment,
                                            description: 'triage for transport to hospital',
                                            necessity: 'receive urgent care')])
      create(:admission,
             patient: @patient,
             facility: @facility,
             observations: [create(:observation, description: 'no soft tissues were damaged'),
                            create(:observation, description: 'appears to be a fracture')],
             diagnoses: [@diagnosis1, @diagnosis2],
             symptoms: [create(:symptom), create(:symptom, description: "his leg is bleeding")],
             created_at: moment_of_admission)
    end

    describe 'transfer_summary' do
      it "should display summary text based on outlined template for summary section" do
        expect(@patient.emergency_transfer_summary).to eql summary_text
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
        @patient.chronic_conditions.last.delete
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

    describe 'procedures_description' do
      it "should clearly describe an individual diagnosis procedure" do
        remove_last_item_in_collection @patient.diagnostic_procedures
        expect(@patient.procedures_description).to eql "an exploratory radiography on February 6, 2021 at 11:00 am"
      end

      it "should clearly describe multiple diagnosis procedures" do
        expect(@patient.procedures_description).to eql "an exploratory radiography on February 6, 2021 at 11:00 am, "\
                                                       "and an ultrasound on February 6, 2021 at 12:30 pm"
      end
    end

    describe 'diagnoses_description' do
      it "should clearly describe an individual diagnosis" do
        @patient.regular_diagnoses.last.delete
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

    describe 'chronic_conditions' do
      it "should return diagnoses marked as chronic_condition" do
        expect(@patient.chronic_conditions).to include(@chronic_condition1, @chronic_condition2)
      end
    end

    describe 'regular_diagnoses' do
      it "should return diagnoses not marked as chronic_condition" do
        expect(@patient.regular_diagnoses).to include(@diagnosis1, @diagnosis2)
      end
    end
  end

  private

  def summary_text
    [
        "This 21 years old male was admitted to Blue Alps Ski Camp "\
        "emergency facility on February 6, 2021 at 11:00 am "\
        "due to right tibia (S82.101A) and fibula (S82.102B). The observed symptoms on admission "\
        "were shooting pain in the leg and his leg is bleeding. No soft tissues were damaged "\
        "and appears to be a fracture.",

        "Upon asking about known allergies, the patient disclosed hypersensitivity to aspirin "\
        "or NSAIDS and gluten intolerance. Upon asking about chronic conditions, the patient "\
        "disclosed Asthma (J45) and Pulmonary Disease (CPOD). "\
        "The patient was administered with Acetaminophen 500mg PO q4hr to relieve pain, "\
        "and Naproxen 500mg IM q6hr to relieve swelling.",

        "The staff performed an exploratory radiography on February 6, 2021 at 11:00 am, "\
        "and an ultrasound on February 6, 2021 at 12:30 pm, revealing right tibia (S82.101A) "\
        "and fibula (S82.102B). Our team proceeded to temporary bracing to restrict the motion "\
        "and to triage for transport to hospital to receive urgent care."
    ].join("\n\n<br><br>")
  end

  def remove_last_item_in_collection(collection)
    collection.destroy collection.last
  end
end
