require 'rails_helper'

RSpec.describe "patients/index", type: :view do
  before(:each) do
    assign(:patients, [
      build_stubbed(:patient,
        first_name: "First Name",
        middle_name: "Middle Name",
        last_name: "Last Name",
        medical_record: 22000,
        gender: 'male'
      ),
      build_stubbed(:patient,
        first_name: "First Name",
        middle_name: "Middle Name",
        last_name: "Last Name",
        medical_record: 20000,
        gender: 'female'
      )
    ])
  end

  it "renders a list of patients" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Middle Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: 22000.to_s, count: 1
    assert_select "tr>td", text: 20000.to_s, count: 1
    assert_select "tr>td", text: "male".to_s, count: 1
    assert_select "tr>td", text: "female".to_s, count: 1
  end
end
