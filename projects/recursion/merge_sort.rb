def merge(left, right)
  arr = []
  (left.size + right.size).times do
    if right.empty?
      arr.concat(left)
      break
    elsif left.empty?
      arr.concat(right)
      break
    end

    if left[0] <= right[0]
      arr << left.shift
    elsif left[0] > right[0]
      arr << right.shift
    end
  end
  arr
end

def merge_sort(arr)
  # sort left half, sort right half, then merge
  return arr if arr.size == 1

  mid = (arr.size / 2).floor
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..])

  merge(left, right)
end

p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
p merge_sort([105, 79, 100, 110])
