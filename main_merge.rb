def merge_sort array
  return array if array.length <= 1

  middle = array.length / 2
  # divided 2 halves of the array
  left_half = merge_sort(array[0...middle])
  right_half = merge_sort(array[middle..-1])

  merge(left_half, right_half)
end

def merge left, right
  sorted = []
  until left.empty? || right.empty?
    if left.first <= right.first
      sorted << left.shift
    else
      sorted << right.shift
    end
  end
  sorted + left + right
end

p merge_sort([3, 2, 1, 13, 8, 5, 0, 1]) # => [0, 1, 1, 2, 3, 5, 8, 13]
p merge_sort([105, 79, 100, 110])       # => [79, 100, 105, 110]
