# Author  mestdagh.ton@gmail.com
# 
# Not optimized for speed

class BitCounter
  attr :filename
  attr :file
  attr :binary

  def initialize(filename = nil)
    raise ArgumentError if filename == nil
    @filename = filename
    load_file @filename
  end

  # Keep binary represenation of file
  def binary
    @binary ||= @file.unpack("B*")[0]
  end

  def count_bits(bit)
    count = 0
    self.binary.scan(/./) do |c|
      count += 1 if c.to_i == bit
    end
    return count
  end

  protected
  def load_file(filename)
    @file = File.binread(filename)
    puts "Counting bits on #{File.basename(filename)}"
  end
end

if __FILE__ == $0
  bit_counter = BitCounter.new(ARGV.shift)
  puts "Found #{bit_counter.count_bits(0)} bits set to 0"
  puts "Found #{bit_counter.count_bits(1)} bits set to 1"
end
