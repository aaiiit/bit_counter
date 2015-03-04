require 'spec_helper'

describe BitCounter do

  it "should raise ArgumentError when there is no filename given" do
    expect { BitCounter.new }.to raise_error(ArgumentError)
  end

  it "should print the correct filename to stdout" do
    expect { BitCounter.new('bit_counter.rb') }.to output("Counting bits on bit_counter.rb\n").to_stdout
  end

  it "should raise exception when file is not found" do
    expect { BitCounter.new('/tmp/this-file-should-not-exist') }.to raise_error(Errno::ENOENT)
  end

  context "valid command" do
    before do
      @bit_counter = BitCounter.new('test.jpg')
    end

    it "should be able to start bit_counter" do
      expect(@bit_counter).not_to eq(nil)
    end

    it "should open file in binary mode" do
      expect(@bit_counter.file.encoding).to eq(Encoding::ASCII_8BIT)
    end

    it "should print contents of file in binary" do
      expect(@bit_counter.binary[0].to_i).to eq(1)
    end

    it "should count bits set to 0" do
      expect(@bit_counter.count_bits(0)).to eq(1855857)
    end

    it "should count bits set to 1" do
      expect(@bit_counter.count_bits(1)).to eq(1829223)
    end

    it 'bits set to 0 should be equal to all bits in bits set to 1' do
      expect(@bit_counter.count_bits(0)).to eq(@bit_counter.binary.length - @bit_counter.count_bits(1))
    end

  end

end
