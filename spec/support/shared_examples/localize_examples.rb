RSpec.shared_examples 'i18n' do
  describe I18n do
    context "en" do
      let(:localized_url) { url + "?locale=en" }

      it "localize should be string" do
        get localized_url
        expect(I18n.locale).to eq(:en)
      end
    end

    context "ru" do
      let(:localized_url) { url + "?locale=ru" }

      it "localize should be string" do
        get localized_url
        expect(I18n.locale).to eq(:ru)
      end
    end

    context "uk" do
      let(:localized_url) { url + "?locale=uk" }

      it "localize should be string" do
        get localized_url
        expect(I18n.locale).to eq(:uk)
      end
    end
  end
end
