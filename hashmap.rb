# frozen_string_literal: true

require_relative 'linked_lists'
require 'pry-byebug'

class HashMap
  INITIAL_BUCKETS = 26
  PRIME_NUMBER = 31
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(INITIAL_BUCKETS) { LinkedList.new }
    @total_entries = 0
  end

  def hash(key)
    key.each_char.reduce(0) { |hash_code, char| PRIME_NUMBER * hash_code + char.ord }
  end

  def index_for(key)
    index = hash(key) % @buckets.length
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  def set(key, value)
    expand_buckets if @total_entries / @buckets.size.to_f > LOAD_FACTOR
    index = index_for(key)
    bucket = @buckets[index]

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
    index = index_for(key)
    bucket = @buckets[index]

    current = bucket.head
    until current.nil?
      return current.value if current.key == key

      current = current.next_node
    end

    nil
  end

  def has(key)
    index = index_for(key)
    bucket = @buckets[index]

    current = bucket.head
    until current.nil?
      return true if current.key == key

      current = current.next_node
    end

    false
  end

  def remove(key)
    index = index_for(key)
    bucket = @buckets[index]

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
      bucket.head = current.next_node
    else
      previous.next_node = current.next_node
    end

    @total_entries -= 1
    current.value
  end

  def expand_buckets
    old_buckets = @buckets
    @buckets = Array.new(@buckets.length * 2) { LinkedList.new }
    @total_entries = 0

    old_buckets.each do |bucket|
      current = bucket.head
      while current
        set(current.key, current.value)
        current = current.next_node
      end
    end
  end

  def iterate_over_buckets
    index_bucket = 0

    while index_bucket < @buckets.length
      index = index_bucket
      raise IndexError if index.negative? || index >= @buckets.length

      bucket = @buckets[index]
      current = bucket.head
      until current.nil?
        yield(current) if block_given?
        current = current.next_node
      end
      index_bucket += 1
    end
  end

  def length
    @total_entries
  end

  def clear
    iterate_over_buckets do |current|
      remove(current.key)
    end
  end

  def keys
    keys_array = []
    iterate_over_buckets { |current| keys_array.push(current.key) }
    keys_array
  end

  def values
    values_array = []
    iterate_over_buckets { |current| values_array.push(current.value) }
    values_array
  end

  def entries
    entries_array = []
    iterate_over_buckets { |current| entries_array.push([current.key, current.value]) }
    entries_array
  end
end
