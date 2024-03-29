require_relative 'hashmap'

# Instantiate a HashMap
my_hashmap = HashMap.new

# Adding key-value pairs
my_hashmap.set("Harry", "Potter")
my_hashmap.set("Ron", "Weasly")
my_hashmap.set("Hermione", "Granger")

# Retrieving values by keys
puts "Harry's surname is #{my_hashmap.get("Harry")}"
puts "Ron's surname is #{my_hashmap.get("Ron")}"
puts "Hermione's surname is #{my_hashmap.get("Hermione")}"

# Display keys, values, and full entries
puts "Keys: #{my_hashmap.keys}"
puts "Values: #{my_hashmap.values}"
puts "Entries: #{my_hashmap.entries}"

# Check for key presence
puts my_hashmap.has("Harry")    # true
puts my_hashmap.has("Draco")    # false

# Removing and checking elements
my_hashmap.remove("Harry")
puts my_hashmap.length          # 2
p my_hashmap.get("Harry")       # nil
puts my_hashmap.has("Harry")    # false

# Listing remaining keys
p my_hashmap.keys               # ["Ron", "Hermione"]

# Clearing the hash map
my_hashmap.clear
puts my_hashmap.length          # 0
puts my_hashmap.keys            # []
