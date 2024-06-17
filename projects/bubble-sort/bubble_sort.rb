def bubble_sort(array)
  for i in (0...array.length)
    for j in (1...array.length-i)
      if array[j-1] > array[j]
        # Swap array[j-1] and array[j]
        array[j - 1], array[j] = array[j], array[j - 1]
      end
    end
  end

  array
end

p bubble_sort([4,3,78,2,0,2])
p bubble_sort([361, 293, 200, 242, 397, 76, 25, 62, 55, 447])
