require "./spec_helper"

describe Hunspell do
  hunspell = Hunspell.new("en_US")

  dict_path = {% if flag?(:darwin) %}
                File.expand_path("~/Library/Spelling")
              {% else %}
                "/usr/share/hunspell"
              {% end %}

  describe "#initialize" do
    context "with dict and aff path" do
      it "should raise error if dictionary file could not be found" do
        expect_raises ArgumentError, "Invalid aff path \"#{dict_path}/en_US.aff_\"" do
          Hunspell.new("#{dict_path}/en_US.aff_", "#{dict_path}/en_US.dic")
        end
      end

      it "should raise error if affix file could not be found" do
        expect_raises ArgumentError, "Invalid dict path \"#{dict_path}/en_US.dic_\"" do
          Hunspell.new("#{dict_path}/en_US.aff", "#{dict_path}/en_US.dic_")
        end
      end
    end

    context "with locale" do
      it "should check if a word is valid" do
        hunspell = Hunspell.new("en_US")
        hunspell.spellcheck("correct").should be_true
      end

      it "should raise error if dictionary files could not be found" do
        expect_raises ArgumentError, "Unable to find the dictionary \"en_US1\" in any of the directories." do
          Hunspell.new("en_US1")
        end
      end
    end
  end

  describe "#encoding" do
    it "should have encoding" do
      hunspell.encoding.should match(/UTF-8|ISO8859-1/)
    end
  end

  describe "#spellcheck" do
    it "should check if a word is valid" do
      hunspell.spellcheck("correct").should be_true
      hunspell.spellcheck("incorect").should be_false
    end
  end

  describe "#analyze" do
    it "should analyze a word" do
      hunspell.analyze("permanently").should eq([" st:permanent fl:Y"])
    end
  end

  describe "#bulk_analyze" do
    it "should analyze words" do
      hunspell.bulk_analyze(["dog", "permanently"]).should eq(
        {"dog" => [" st:dog"], "permanently" => [" st:permanent fl:Y"]}
      )
    end
  end

  describe "#suggest" do
    it "should suggest alternate spellings for words" do
      hunspell.suggest("incorect").should contain("incorrect")
    end

    context "when there are no suggestions" do
      it "should return []" do
        hunspell.suggest("________").should be_empty
      end
    end
  end

  describe "#bulk_suggest" do
    it "should suggest alternate spellings for words" do
      hunspell.bulk_suggest(["correct", "incorect"]).should eq(
        {"correct"  => ["correct", "corrects", "cor rect", "cor-rect"],
         "incorect" => ["incorrect", "correction", "corrector", "injector", "correct"]})
    end
  end

  describe "#suffix_suggest" do
    it "should suffix_suggest alternate spellings for words" do
      hunspell.suffix_suggest("do").should eq(
        ["dew", "od", "so", "fo", "di", "d", "o", "doe", "dos", "ado", "don", "dor", "dot", "dol", "doc"]
      )
    end

    context "when there are no suggestions" do
      it "should return []" do
        hunspell.suffix_suggest("________").should be_empty
      end
    end
  end

  describe "#bulk_suffix_suggest" do
    it "should suggest alternate spellings for words" do
      result = hunspell.bulk_suffix_suggest(["cat", "do"])

      result["cat"].should contain("car")
      result["do"].should contain("dot")
    end
  end

  describe "#stem" do
    it "should find the stems of a word" do
      hunspell.stem("fishing").should eq(["fishing", "fish"])
    end

    context "when there are no stems" do
      it "should return []" do
        hunspell.stem("________").should be_empty
      end
    end
  end

  describe "#bulk_stem" do
    it "should find the stems of a word" do
      hunspell.bulk_stem(["stems", "currencies"]).should eq({"stems" => ["stem"], "currencies" => ["currency"]})
    end
  end

  describe "#add" do
    it "should adds a word to the dictionary." do
      hunspell.spellcheck("userpass").should be_false
      hunspell.add("userpass")
      hunspell.spellcheck("userpass").should be_true
      hunspell.remove("userpass")
    end

    context "with affix" do
      it "should adds a word to the dictionary." do
        hunspell.spellcheck("userpass").should be_false
        hunspell.add("userpass", "example")
        hunspell.spellcheck("userpass").should be_true
        hunspell.remove("userpass")
      end
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
end
