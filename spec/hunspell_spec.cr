require "./spec_helper"

describe Hunspell do
  hunspell = Hunspell.new("/usr/share/hunspell/en_US.aff", "/usr/share/hunspell/en_US.dic")

  describe "#encoding" do
    it "should have encoding" do
      hunspell.encoding.should match(/UTF-8|ISO8859-1/)
    end
  end

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
      hunspell.suggest("crystal").should contain("crustal")
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

  describe "#add" do
    it "should adds a word to the dictionary." do
      hunspell.spellcheck("userpass").should be_false
      hunspell.add("userpass")
      hunspell.spellcheck("userpass").should be_true
      hunspell.remove("userpass")
    end
  end

  describe "#add_with_affix" do
    it "should adds a word to the dictionary." do
      hunspell.spellcheck("userpass").should be_false
      hunspell.add_with_affix("userpass", "example")
      hunspell.spellcheck("userpass").should be_true
      hunspell.remove("userpass")
    end
  end

  context "initialized with locale" do
    hunspell = Hunspell.new("en_US")

    it "should check if a word is valid" do
      hunspell.spellcheck("crystal").should be_true
    end

    it "should raise error if dictionary files could not be found" do
      expect_raises ArgumentError do
        Hunspell.new("en_US1")
      end
    end
  end
end
