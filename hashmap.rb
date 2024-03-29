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

  def has(key)
    index = hash(key) % @buckets.length
    bucket = @buckets[index]

    current = bucket.head
    until current.nil?
      return true if current.key == key
      current = current.next_node
    end

    false
  end

  def remove(key)
    index_bucket = hash(key) % @buckets.length
    bucket = @buckets[index_bucket]

    current = bucket.head
    previous = nil

    while !current.nil? && current.key != key
      previous = current
      current = current.next_node
    end

    if current.nil?
      puts 'Key did not exist'
      return nil
    end

    if previous.nil?
      bucket.head = current.next_node # If 1st key removed, adjust head
    else
      previous.next_node = current.next_node # Other than that, bypass/adjust previous node's next_node
    end

    @total_entries -= 1
    current.value
  end

  def length
    count = 0
    index_bucket = 0

    while index_bucket < INITIAL_BUCKETS
      bucket = @buckets[index_bucket]
      current = bucket.head
      until current.nil?
        count += 1
        current = current.next_node
      end
      index_bucket += 1
    end

    count
  end


end
