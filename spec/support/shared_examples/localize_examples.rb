RSpec.shared_examples "i18n" do
  describe I18n do
    context "en" do
      let(:localized_url) { url + "?locale=en" }

      it "localize should be string" do
        get localized_url
        expect(I18n.locale).to eq(:en)
      end
    end

    context "ua" do
      let(:localized_url) { url + "?locale=ua" }

      it "localize should be string" do
        get localized_url
        expect(I18n.locale).to eq(:ua)
      end
    end
  end
end
