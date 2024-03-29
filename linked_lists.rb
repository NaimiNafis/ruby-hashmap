require_relative 'node'

class LinkedList
  attr_accessor :head

  def initialize(head = nil)
    @head = head
  end

  def append(key, value)
    new_node = Node.new(key, value)
    if @head.nil?
      @head = new_node
    else
      current = @head
      current = current.next_node until current.next_node.nil?
      current.next_node = new_node
    end
  end

  def contains?(key)
    return false if @head.nil?

    current = @head
    until current.nil?
      return true if current.key == key

      current = current.next_node
    end
    false
  end

end
