require "experiment"

describe "#get_rid_of_surrounding_whitespaces" do

  it "should get rid of both leading and trailing whitespaces" do
    expect( get_rid_of_surrounding_whitespaces("  hey yo  ") ).to eq("hey yo")
    expect( get_rid_of_surrounding_whitespaces(" nice try!") ).to eq("nice try!")
  end

end