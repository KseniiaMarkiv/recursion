require 'colorize'

class HashSet 
  attr_reader :buckets, :load_factor

  INITIAL_BUCKET_SIZE = 16
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(INITIAL_BUCKET_SIZE)
    @size = 0
    @load_factor = LOAD_FACTOR
  end

  def hash key
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set key
    resize_if_needed
    index = bucket_index(key)

    @buckets[index] ||= []
    bucket = @buckets[index]

    unless bucket.include?(key)
      bucket << key
      @size += 1
    end
  end

  def get key
    index = bucket_index(key)
    bucket = @buckets[index]
    bucket && bucket.include?(key) ? key : "#{key} is not exist".colorize(:background => :red)
  end

  def has? key
    get(key) != nil
  end

  def remove key
    if has?(key)
      index = bucket_index(key)
      bucket = @buckets[index]
      bucket.delete(key)
      @size -= 1
    else
      "Key '#{key}' not found"
    end
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(INITIAL_BUCKET_SIZE)
    @size = 0
  end

  def keys
    @buckets.compact.flat_map { |bucket| bucket }
  end

  def map
    return enum_for(:map) unless block_given?
    
    result = []
    @buckets.compact.each do |bucket|
      bucket.each do |key|
        result << yield(key)
      end
    end
    result
  end

  def each
    return enum_for(:each) unless block_given?
    
    @buckets.compact.each do |bucket|
      bucket.each do |key|
        yield(key)
      end
    end
    self
  end

private

def bucket_index key
  index = hash(key) % @buckets.length
  raise IndexError if index.negative? || index >= @buckets.length
  index
end

def resize_if_needed
  #   @size.to_f / @buckets.length   -  current load factor
  return unless @size.to_f / @buckets.length >= @load_factor

  new_buckets = Array.new(@buckets.length * 2)
  @buckets.each do |bucket|
    next unless bucket

    bucket.each do |key|
      new_index = hash(key) % new_buckets.length
      new_buckets[new_index] ||= []
      new_buckets[new_index] << key
    end
  end
    @buckets = new_buckets
  end

end

# Testing the HashSet

test_set = HashSet.new
test_set.set('apple')
test_set.set('banana')
test_set.set('carrot')
test_set.set('dog')
test_set.set('elephant')
test_set.set('frog')
test_set.set('grape')
test_set.set('hat')
test_set.set('ice cream')
test_set.set('jacket')
test_set.set('kite')
test_set.set('lion')

puts "Keys in the set:".colorize(:blue)
puts test_set.keys.inspect # should return all keys

puts "Get 'frog' key:".colorize(:blue)
puts test_set.get('frog') # should return 'frog'

puts "Get 'nonexistent' key:".colorize(:blue)
puts test_set.get('nonexistent') # should return nil

puts "Remove 'banana'".colorize(:blue)
puts test_set.remove('banana') # should return 'banana'
puts test_set.keys.inspect # should not include 'banana'

puts "Length of the set".colorize(:blue)
puts test_set.length # should return 11

test_set.clear
puts "Set cleared, length is now:".colorize(:blue)
puts test_set.length # should return 0