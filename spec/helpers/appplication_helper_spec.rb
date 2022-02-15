require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "full title" do
    it "should be main" do
      expect(helper.full_title()).to eq("OrderApi")
    end

    it "should be modificate" do
      expect(helper.full_title("Demo")).to eq("Demo | OrderApi")
    end
  end
end
