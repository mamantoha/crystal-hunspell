require "./spec_helper"

describe Hunspell do
  hunspell = Hunspell.new("/usr/share/hunspell/en_US.aff", "/usr/share/hunspell/en_US.dic")

  describe "#spellcheck" do
    it "should check if a word is valid" do
      hunspell.spellcheck("crystal").should be_true
      hunspell.spellcheck("cristal").should be_false
    end
  end

  describe "#analyze" do
    it "should analyze a word" do
      hunspell.analyze("crystal").should eq([" st:crystal"])
    end
  end

  describe "#suggest" do
    it "should suggest alternate spellings for words" do
      hunspell.suggest("arbitrage").should eq(["arbitrage", "arbitrages", "arbitrager", "arbitraged", "arbitrate"])
    end

    context "when there are no suggestions" do
      it "should return []" do
        hunspell.suggest("________").should be_empty
      end
    end
  end

  describe "#stem" do
    it "should find the stems of a word" do
      hunspell.stem("fishing").should eq(["fishing", "fish"])
    end

    context "when there are no stems" do
      it "should return []" do
        hunspell.stem("zzzzzzz").should be_empty
      end
    end
  end
end
