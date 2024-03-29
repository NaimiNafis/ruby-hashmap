# frozen_string_literal: true

require_relative 'linked_lists'
require 'pry-byebug'

class HashMap
  INITIAL_BUCKETS = 26
  PRIME_NUMBER = 31

  def initialize
    @buckets = Array.new(INITIAL_BUCKETS) { LinkedList.new }
    @total_entries = 0
  end

  def hash(key)
    key.each_char.reduce(0) { |hash_code, char| PRIME_NUMBER * hash_code + char.ord }
  end

  def index_for(key)
    hash(key) % @buckets.length
  end

  def set(key, value)
    bucket = @buckets[index_for(key)]

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
    bucket = @buckets[index_for(key)]

    current = bucket.head
    until current.nil?
      return current.value if current.key == key

      current = current.next_node
    end

    nil
  end

  def has(key)
    bucket = @buckets[index_for(key)]

    current = bucket.head
    until current.nil?
      return true if current.key == key

      current = current.next_node
    end

    false
  end

  def remove(key)
    bucket = @buckets[index_for(key)]

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

  def iterate_over_buckets
    index_bucket = 0

    while index_bucket < INITIAL_BUCKETS
      bucket = @buckets[index_bucket]
      current = bucket.head
      until current.nil?
        yield(current) if block_given?
        current = current.next_node
      end
      index_bucket += 1
    end
  end

  def length
    count = 0
    iterate_over_buckets do |_current|
      count += 1
    end
    count
  end

  def clear
    iterate_over_buckets do |current|
      remove(current.key)
    end
  end

  def keys
    keys_array = []
    iterate_over_buckets do |current|
      keys_array.push(current.key)
    end
    keys_array
  end

  def values
    values_array = []
    iterate_over_buckets do |current|
      values_array.push(current.value)
    end
    values_array
  end

  def entries
    entries_array = []
    iterate_over_buckets do |current|
      entries_array.push([current.key, current.value])
    end
    entries_array
  end
end
