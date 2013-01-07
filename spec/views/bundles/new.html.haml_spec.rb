require 'spec_helper'

describe "bundles/new" do
  before(:each) do
    assign(:bundle, stub_model(Bundle).as_new_record)
  end

  it "renders new bundle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bundles_path, :method => "post" do
    end
  end
end
