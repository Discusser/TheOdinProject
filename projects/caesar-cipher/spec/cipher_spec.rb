require_relative "../lib/cipher"

describe CaesarCipher do
  describe "#shift_string" do
    context "with a string that contains non-alphabetical characters" do
      subject(:cipher_mixed) { described_class.new("Hello, world!", 10) }

      it "doesn't shift the non-alphabetical characters" do
        expect(cipher_mixed.shift_string).to eql("Rovvy, gybvn!")
      end
    end
    context "with negative shift factor" do
      subject(:cipher_negative) { described_class.new("Test", 0) }
      it "works with a small shift factor" do
        cipher_negative.shift_factor = -4
        expect(cipher_negative.shift_string).to eql("Paop")
      end

      it "works with a big shift factor" do
        cipher_negative.shift_factor = -37
        expect(cipher_negative.shift_string).to eql("Ithi")
      end

      it "wraps correctly" do
        cipher_negative.shift_factor = -4
        small_shift = cipher_negative.shift_string
        cipher_negative.shift_factor = -30
        big_shift = cipher_negative.shift_string
        expect(small_shift).to eql(big_shift)
      end
    end
    context "with a positive shift factor" do
      subject(:cipher_positive) { described_class.new("Test", 0) }
      it "works with a small shift factor" do
        cipher_positive.shift_factor = 4
        expect(cipher_positive.shift_string).to eql("Xiwx")
      end

      it "works with a big shift factor" do
        cipher_positive.shift_factor = 37
        expect(cipher_positive.shift_string).to eql("Epde")
      end

      it "wraps correctly" do
        cipher_positive.shift_factor = 4
        small_shift = cipher_positive.shift_string
        cipher_positive.shift_factor = 30
        big_shift = cipher_positive.shift_string
        expect(small_shift).to eql(big_shift)
      end
    end
  end
end
