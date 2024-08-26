# Linked List Implementation in Ruby

This project involves building a `LinkedList` and `Node` class in Ruby. The goal is to understand and implement the core functionality of linked lists, including adding, removing, and manipulating nodes.

## Classes

### `LinkedList`
This class represents the full linked list and includes methods to manage the nodes.

### `Node`
This class represents a single node in the linked list. It contains:
- `#value`: The value of the node.
- `#next_node`: A reference to the next node in the list, which is `nil` by default.

## Methods

### LinkedList Class Methods

- `#append(value)`
  - Adds a new node containing `value` to the end of the list.

- `#prepend(value)`
  - Adds a new node containing `value` to the start of the list.

- `#size`
  - Returns the total number of nodes in the list.

- `#head`
  - Returns the first node in the list.

- `#tail`
  - Returns the last node in the list.

- `#at(index)`
  - Returns the node at the given index.

- `#pop`
  - Removes the last element from the list.

- `#contains?(value)`
  - Returns `true` if the passed-in value is in the list, otherwise returns `false`.

- `#find(value)`
  - Returns the index of the node containing `value`, or `nil` if not found.

- `#to_s`
  - Represents the linked list as a string in the format:
    `( value ) -> ( value ) -> ( value ) -> nil`

### Extra Credit Methods

- `#insert_at(value, index)`
  - Inserts a new node with the provided `value` at the given index.

- `#remove_at(index)`
  - Removes the node at the given index.

**Note:** When inserting or removing nodes, make sure to update the `#next_node` links of the adjacent nodes accordingly.

