require 'rails_helper'

RSpec.describe SearchWords do
  describe ".search" do
    context "Given the min_word_length argument" do
      it "returns words greater than or equal to the min length" do
        results = described_class.search(min_word_length: 11,sortby: "alphabetical")
        expect(results.any? { |x| x.length < 11 }).to eq(false)
      end
    end
    context "Given the max_word_length argument" do
      it "returns words with less than or equal to the max length" do
        results = described_class.search(max_word_length: 5, sortby: "alphabetical")
        expect(results.any? { |x| x.length > 5 }).to eq(false)
      end
    end

    context "given the starts_with argument" do
      it "returns words that start with the given value" do
        results = described_class.search(starts_with: "z", sortby: "alphabetical")
        expect(results.all? { |x| x.start_with?("z") }).to eq(true)
      end
    end

    context "given the ends_with argument" do
      it "returns words that end with the given value" do
        results = described_class.search(ends_with: "z", sortby: "alphabetical")
        expect(results.all? { |x| x.end_with?("z") }).to eq(true)
      end
    end

    context "given the dont_include argument" do
      it "returns words that dont include the given value(s)" do
        results = described_class.search(dont_include: "a,e,i,o,u", sortby: "alphabetical")
        expect(results.any? { |x| x.include?("a", "e", "i", "o", "u") }).to eq(false)
      end
    end

    context "Given that word_typed_only is true" do
      it "returns only the word typed" do
      results = described_class.search(query: "and", word_typed_only: true, sortby: "alphabetical")
      expect(results[0] == "and").to eq(true)
      expect(results.size == 1).to eq(true)
      end
    end

  end
end