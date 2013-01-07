require 'spec_helper'

describe "bundles/show" do
  before(:each) do
    @bundle = assign(:bundle, stub_model(Bundle))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
