require_relative 'hashmap'

# Create a new HashMap
my_hash_map = HashMap.new

# Set key-value pairs
my_hash_map.set("name", "John")
my_hash_map.set("age", 25)
my_hash_map.set("city", "New York")

# Retrieve values
puts "Name: #{my_hash_map.get("name")}"
puts "Age: #{my_hash_map.get("age")}"
puts "City: #{my_hash_map.get("city")}"

# Returns the number of stored keys in the hash map
puts my_hash_map.length

my_hash_map.remove("name")
puts my_hash_map.length
puts my_hash_map.get("name")
