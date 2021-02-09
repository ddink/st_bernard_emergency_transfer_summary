require 'rails_helper'

RSpec.describe 'Rails.application' do
  describe '#load_seed' do
    subject { Rails.application.load_seed }

    it do
      expect { subject }.to change(User, :count).by(2)
                                .and change(Facility, :count).by(1)
                                .and change(Admission, :count).by(3)
                                .and change(Observation, :count).by(6)
                                .and change(Treatment, :count).by(6)
                                .and change(Symptom, :count).by(6)
                                .and change(Allergy, :count).by(6)
                                .and change(Diagnosis, :count).by(18)
                                .and change(DiagnosticProcedure, :count).by(6)
                                .and change(OrderFrequency, :count).by(6)
                                .and change(MedicationOrder, :count).by(6)
                                .and change(Patient, :count).by(3)
    end
  end
end