require 'spec_helper'

describe "bundles/index" do
  before(:each) do
    assign(:bundles, [
      stub_model(Bundle),
      stub_model(Bundle)
    ])
  end

  it "renders a list of bundles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
