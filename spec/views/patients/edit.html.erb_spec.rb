require 'rails_helper'

RSpec.describe "patients/edit", type: :view do
  before(:each) do
    @patient = assign(:patient, build_stubbed(:patient,
      first_name: "Jane",
      middle_name: "Quincy",
      last_name: "Doe",
      medical_record: 12000,
      gender: 'female'
    ))
  end

  it "renders the edit patient form" do
    render

    assert_select "form[action=?][method=?]", patient_path(@patient), "post" do

      assert_select "input[name=?]", "patient[first_name]"

      assert_select "input[name=?]", "patient[middle_name]"

      assert_select "input[name=?]", "patient[last_name]"

      assert_select "input[name=?]", "patient[medical_record]"

      assert_select "input[name=?]", "patient[gender]"
    end
  end
end
