# Ruby HashMap Implementation Overview

This guide presents a Ruby-based hash map, part of [The Odin Project curriculum](https://www.theodinproject.com/lessons/ruby-hashmap). It showcases a hash map structure enhanced by a linked list to manage collisions, aimed at efficiency and simplicity for various use cases.

## Included Files

### `linked_list.rb`

Defines the `LinkedList` class for collision resolution. It uses a dynamic approach for the fast handling of key-value pairs through a series of nodes linked together, each holding a key, value, and reference to the next node.

### `hashmap.rb`

Defines the `HashMap` class, illustrating an efficient hash map mechanism. Initialized with a default set of buckets (26), it supports key-value pair operations, value retrieval, key existence verification, load factor for expandable buckets and complete data clearance.

### `node.rb`

The `Node` class defines the structure of a node in the linked list. Each node encapsulates a key, data(value), and a reference to the next node. This class is an integral part of the linked list and contributes to the overall functionality of the hash map.

## Key Features

- **Collision Handling**: Adopts linked lists for effective collision management.
- **Dynamic Sizing**: Allows customization of the bucket count for performance tuning.
- **Comprehensive Key-Value Management**: Facilitates key-value pair addition, retrieval, and existence checking.
- **Element Clearance**: Enables removing all elements from the hash map efficiently.

## Example Usage

```ruby
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
p my_hashmap.get("Harry")    # nil
puts my_hashmap.has("Harry")    # false

# Listing remaining keys
p my_hashmap.keys               # ["Ron", "Hermione"]

# Clearing the hash map
my_hashmap.clear
puts my_hashmap.length          # 0
puts my_hashmap.keys            # []

```

`
