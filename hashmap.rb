require_relative 'linked_lists'
require 'pry-byebug'

class HashMap
  INITIAL_BUCKETS = 26

  def initialize
    @buckets = Array.new(INITIAL_BUCKETS) { LinkedList.new }
    @total_entries = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @buckets.length
    bucket = @buckets[index] # Instantiate LinkedList obj

    if bucket.contains?(key)
      current = bucket.head
      until current.nil?
        if current.key == key
          current.value = value
          return
        end
        current = current.next_node
      end
    else
      bucket.append(key, value)
      @total_entries += 1
    end
  end

  def get(key)
    index = hash(key) % @buckets.length
    bucket = @buckets[index]

    current = bucket.head
    until current.nil?
      return current.value if current.key == key
      current = current.next_node
    end

    nil
  end

end
