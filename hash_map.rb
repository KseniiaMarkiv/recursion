require 'colorize'

class HashMap 
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

  def set key, value
    resize_if_needed
    index = bucket_index(key)

    @buckets[index] ||= []
    bucket = @buckets[index]

    existing_entry = bucket.find { |entry| entry[0] == key }
    if existing_entry
      # reassign existing value
      existing_entry[1] = value
    else
      bucket << [key, value]
      @size += 1
    end
  end

  def get key
    index = bucket_index(key)
    bucket = @buckets[index]

    return nil unless bucket

    entry = bucket.find { |entry| entry[0] == key }
    entry ? entry[1] : nil
  end
  
  def has? key
    get(key) != nil ? true : false
  end

  def remove key
    if has?(key)
      index = bucket_index(key)
      bucket = @buckets[index]
      entry = bucket.find { |e| e[0] == key }
      bucket.delete(entry) if entry
      @size -= 1
      entry[1] if entry
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
    @buckets.compact.flat_map { |bucket| bucket.map { |entry| entry[0] } }
  end

  def values
    @buckets.compact.flat_map { |bucket| bucket.map { |entry| entry[1] } }
  end

  def entries
    @buckets.compact.flat_map { |bucket| bucket.map { |entry| entry } }
  end

  def map
    return enum_for(:map) unless block_given?
    
    result = []
    @buckets.compact.each do |bucket|
      bucket.each do |entry|
        key, value = entry
        result << yield(key, value)
      end
    end
    result
  end

  def each_pair
    return enum_for(:each_pair) unless block_given?
    
    @buckets.compact.each do |bucket|
      bucket.each do |entry|
        key, value = entry
        yield(key, value)
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

      bucket.each do |entry|
        key, value = entry
        new_index = hash(key) % new_buckets.length
        new_buckets[new_index] ||= []
        new_buckets[new_index] << [key, value]
      end
    end
    @buckets = new_buckets
  end
end




# Testing the HashMap

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts "A whole array".colorize(:blue)
mapped_result = test.map do |key, value|
  "#{key.capitalize}: #{value.upcase}"
end
p mapped_result 

puts "A whole hash".colorize(:blue)
hash_result = test.each_pair do |key, value|
  puts "#{key}: #{value}"
end
p hash_result

puts "Overwrite existing values".colorize(:blue)
puts "Was - ".colorize(:red) + test.get('apple') # should return 'red'
test.set('apple', 'green')
test.set('lion', 'brown')
puts "Become - ".colorize(:red) + test.get('apple') # should return 'green'


puts "Add a new key that exceeds the load factor".colorize(:blue)
test.set('moon', 'silver')

# Testing methods
puts test.get('moon') # should return 'silver'
puts test.has?('frog') # should return true
puts test.remove('banana') # should return 'yellow'
puts test.length # should return 12
puts test.keys.inspect # should return all keys
puts test.values.inspect # should return all values
puts test.entries.inspect # should return all entries
test.clear
puts test.length # should return 0


